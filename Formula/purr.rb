class Purr < Formula
  desc "A powerful terminal utility"
  homepage "https://github.com/gaetschwartz/purr"
  license "MIT"

  head "https://github.com/gaetschwartz/purr.git", branch: "develop"

  depends_on "rust" => :build
  depends_on "cmake" => :build

  def install
    # Disable sccache to avoid build issues
    ENV.delete("RUSTC_WRAPPER")
    ENV["SCCACHE_DISABLE"] = "1"
    ENV["CMAKE_C_COMPILER"] = ENV.cc
    ENV["CMAKE_CXX_COMPILER"] = ENV.cxx

    # First test without features to avoid complex build dependencies
    # TODO: Add back coreml,metal features once build environment is stable
    system "cargo", "install", "--locked", "--root", prefix, "--path", "crates/purr"
  end

  test do
    # Test that the binary was installed
    system "#{bin}/purr", "--version"
  end
end