class Landin < Formula
  desc "Compiler for the Landin systems programming language"
  homepage "https://www.701.dev/"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/701-dev/Landin/releases/download/v0.2.11/landin-0.2.11-aarch64-darwin.tar.gz"
      sha256 "b4c121ca536fc2237b1da2ced7c63aaeaf0b1fa882456546272011693b906880"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/701-dev/Landin/releases/download/v0.2.11/landin-0.2.11-aarch64-linux.tar.gz"
      sha256 "1619ab42b19c226d2f1d62bf2314432863452d42035f71689b638b848f85ba06"
    end
    on_intel do
      url "https://github.com/701-dev/Landin/releases/download/v0.2.11/landin-0.2.11-x86_64-linux.tar.gz"
      sha256 "a0e546c97f11b0c47f643ba5a3610808c9a514dfe19e48b91bcd5d8f9da53451"
    end
  end

  def install
    # The archive is the install tree: refine finds lib/landin beside the
    # bin/ its executable is in, also when started through a symlink.
    prefix.install Dir["*"]
  end

  def caveats
    on_linux do
      <<~EOS
        refine links programs through the system's GCC driver. If none is
        installed, refine names the drivers it looked for.
      EOS
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/refine version")
    # refine finds its split commands in libexec/landin through its own
    # resolved path, which Homebrew does not link into the prefix.
    assert_match "usage: refine svd", shell_output("#{bin}/refine svd --help")
    (testpath/"main.ldn").write <<~LANDIN
      import core/io
      import hosted/blocking

      public main: () -> (code: i32) =
          host := blocking.new()
          io.write(host, io.out(host), "Hello, world!\\n") else none
          code = 0
      end main
    LANDIN
    assert_equal "Hello, world!\n", shell_output("#{bin}/refine run main.ldn")
  end
end
