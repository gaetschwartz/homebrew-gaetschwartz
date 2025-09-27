class Purr < Formula
  desc "A powerful terminal utility"
  homepage "https://github.com/gaetschwartz/purr"
  license "MIT"

  head "https://github.com/gaetschwartz/purr.git", branch: "develop"

  depends_on "rust" => :build
  depends_on "cmake" => :build
  depends_on "sccache" => :build
  depends_on "ffmpeg" => :build

  def install
    system "cargo", "install", "--locked", "--root", prefix, "--path", "crates/purr", "--features", "coreml,metal"
  end

  test do
    # Test that the binary was installed
    system "#{bin}/purr", "--version"
  end
end
