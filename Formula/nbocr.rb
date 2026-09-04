class Nbocr < Formula
  desc "A powerful and easy-to-use CLI tool for OCR based on ocr-rs"
  homepage "https://github.com/zibo-chen/newbee-ocr-cli"
  version "0.2.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/zibo-chen/newbee-ocr-cli/releases/download/v0.2.3/newbee_ocr_cli-aarch64-apple-darwin.tar.xz"
      sha256 "cf587aeb9ce7df44eb6d89d515d06ceef3ac5566dee81936f15d0e37b6c20744"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zibo-chen/newbee-ocr-cli/releases/download/v0.2.3/newbee_ocr_cli-x86_64-apple-darwin.tar.xz"
      sha256 "a7f89f50897d8bfd00f020e205fb9c5265ac2807d146ca87e7898a67675cb4b0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/zibo-chen/newbee-ocr-cli/releases/download/v0.2.3/newbee_ocr_cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "555145384af2c004fdc2bde25226ccc60b03669e2f3f6b222605dfa882b2d7ea"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zibo-chen/newbee-ocr-cli/releases/download/v0.2.3/newbee_ocr_cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5e34f9c4d076e2e7034f655836e1031ec99abe287ffd0d375fda35cdec10eabc"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {}
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "nbocr"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "nbocr"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "nbocr"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "nbocr"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
