class KillServer < Formula
    desc "A script to kill a server running on a specified port"
    homepage "https://github.com/mj-963/kill-server"
    url "https://github.com/mj-963/kill-server/archive/v1.0.0.tar.gz"
    sha256 "your_sha256_checksum_here"
  
    def install
      bin.install "kill-server.sh" => "kill-server"
    end
  
    test do
      system "#{bin}/kill-server", "--version"
    end
  end
  