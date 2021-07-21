require "./spec_helper"

describe UniqHistory::Filter do
  it "doesn't filter if there are no dups" do
    history = <<-HISTORY
    1 git status
    2 git add .
    HISTORY
    io = IO::Memory.new(history)

    expected = <<-HISTORY
    1     git status
    2     git add .
    HISTORY
    UniqHistory::Filter.new(io).de_duplicate.should eq expected
  end

  it "filters duplicates" do
    history = <<-HISTORY
    1 git status
    2 git add .
    3 git status
    HISTORY
    io = IO::Memory.new(history)

    expected = <<-HISTORY
    1     git status
    2     git add .
    HISTORY
    UniqHistory::Filter.new(io).de_duplicate.should eq expected
  end

  it "filters ending spaces" do
    history = <<-HISTORY
    1 git status
    2 git add .
    3 git status\t
    HISTORY
    io = IO::Memory.new(history)

    expected = <<-HISTORY
    1     git status
    2     git add .
    HISTORY
    UniqHistory::Filter.new(io).de_duplicate.should eq expected
  end

  it "works with large command numbers" do
    history = <<-HISTORY
    123 git status
    2829 git add .
    31416 git status
    \n
    HISTORY
    io = IO::Memory.new(history)

    expected = <<-HISTORY
    123   git status
    2829  git add .
    HISTORY
    UniqHistory::Filter.new(io).de_duplicate.should eq expected
  end
end
