class Timely < Formula
  desc "A lightweight, agent-friendly activity tracker for macOS"
  homepage "https://github.com/Bhavikpatel576/timely"
  version "0.3.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Bhavikpatel576/timely/releases/download/v#{version}/timely-v#{version}-arm64-apple-darwin-bin.tar.gz"
      sha256 "33fc995a4209dba8eb16e62182dd1f73b45b78eafa51e5a4fe5679f0f620677b"
    else
      url "https://github.com/Bhavikpatel576/timely/releases/download/v#{version}/timely-v#{version}-x86_64-apple-darwin-bin.tar.gz"
      sha256 "67fddce1610dba602dc59ce1a78a6263462ecdb61df7ba3a3efefd607b498cb0"
    end
  end

  depends_on :macos

  def install
    bin.install "timely"
  end

  def caveats
    <<~EOS
      Timely requires Accessibility permissions to track window activity.

      After installing, grant access:
        1. Open System Settings > Privacy & Security > Accessibility
        2. Click '+' and add the terminal you run timely from

      Start the background daemon:
        timely daemon start

      The daemon will start automatically on login via launchd.
    EOS
  end

  test do
    assert_match "timely", shell_output("#{bin}/timely --help")
  end
end
