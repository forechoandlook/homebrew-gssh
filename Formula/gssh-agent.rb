class GsshAgent < Formula
  desc "SSH Session Manager for Agents"
  homepage "https://github.com/forechoandlook/gssh"
  license "MIT"
  version "1.0.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/forechoandlook/gssh/releases/download/v1.0.0/gssh-darwin-arm64.tar.gz"
      sha256 "6d10b8cad1384a326e85f9389f295103031a7102b6c1702a413101e3e134c369"
    else
      url "https://github.com/forechoandlook/gssh/releases/download/v1.0.0/gssh-darwin-amd64.tar.gz"
      sha256 "TODO: update with actual sha256 for amd64"
    end
  end

  def install
    bin.install "gssh"
    bin.install "gssh-daemon"
    prefix.install "com.gssh.daemon.plist"
  end

  def post_install
    (var/"log").mkdir if !var.exist?("log")
    (Library/"LaunchAgents").mkdir unless (Library/"LaunchAgents").exist?
    ln_sf "#{prefix}/com.gssh.daemon.plist", "#{Library}/LaunchAgents/com.gssh.daemon.plist"
  end

  test do
    system "#{bin}/gssh", "--help"
  end
end
