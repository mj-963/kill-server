class KillServer < Formula
    desc "A script to kill a server running on a specified port"
    homepage "https://github.com/mj-963/kill-server"
    url "https://github.com/mj-963/kill-server/archive/v1.0.0.tar.gz"
    sha256 "0c6a8c45f2177fa24150e2d1a4e48497c745491f11c1e743c6f45cc56a1ff94b"
  
    def install
      bin.install "kill-server.sh" => "kill-server"
    end
  
    test do
      system "#{bin}/kill-server", "--version"
    end
  end
  