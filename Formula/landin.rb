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
      url "https://github.com/701-dev/Landin/releases/download/v0.2.10/landin-0.2.10-aarch64-darwin.tar.gz"
      sha256 "cad6d5264e61124f9ea4da85b3a3a4a25c7ea6af53655ac0ad3a867ed4c313e9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/701-dev/Landin/releases/download/v0.2.10/landin-0.2.10-aarch64-linux.tar.gz"
      sha256 "e1acba936b36772cafd16d53f646f51264f9c3673e00553f8c44f9a237edb3ca"
    end
    on_intel do
      url "https://github.com/701-dev/Landin/releases/download/v0.2.10/landin-0.2.10-x86_64-linux.tar.gz"
      sha256 "525374ce73d7bfea553be1456f27f1421fbe4f605401e33597afaf0f5675f48f"
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
