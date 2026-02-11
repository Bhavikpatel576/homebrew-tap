class Timely < Formula
  desc "A lightweight, agent-friendly activity tracker for macOS"
  homepage "https://github.com/Bhavikpatel576/timely"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Bhavikpatel576/timely/releases/download/v#{version}/timely-v#{version}-arm64-apple-darwin.tar.gz"
      sha256 "c4014042232f3a0ee64758a588e4c49e26e3f0905cdd67af821e74846bea91f9"
    else
      url "https://github.com/Bhavikpatel576/timely/releases/download/v#{version}/timely-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "b417fd228c8540b674d8aee0daf347602ef4ff505399d72938fe06193291c3b0"
    end
  end

  depends_on :macos

  def install
    # The tarball contains Timely.app bundle
    prefix.install "Timely.app"
    bin.write_exec_script prefix/"Timely.app/Contents/MacOS/timely"
  end

  def caveats
    <<~EOS
      Timely requires Accessibility permissions to track window activity.

      After installing, grant access:
        1. Open System Settings > Privacy & Security > Accessibility
        2. Click '+' and add Timely (or the terminal you run it from)

      Start the background daemon:
        timely daemon start

      The daemon will start automatically on login via launchd.
    EOS
  end

  test do
    assert_match "timely", shell_output("#{bin}/timely --help")
  end
end
