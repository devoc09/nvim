# nvim

personal neovim settings

## Requirements

- Neovim nightly (0.13+)
- C compiler (`cc`)
- [tree-sitter CLI](https://github.com/tree-sitter/tree-sitter/blob/master/crates/cli/README.md) (0.26+)
- [fzf](https://github.com/junegurin/fzf)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [fd](https://github.com/sharkdp/fd)

## Setup

### 1. プラグインのインストール

Neovim を起動すると `vim.pack` が自動的にプラグインをダウンロードする。

### 2. Tree-sitter パーサーのインストール

Neovim には以下のパーサーが同梱されている (インストール不要):

`c`, `lua`, `vim`, `vimdoc`, `query`, `markdown`, `markdown_inline`

それ以外の言語は `tree-sitter` CLI でコンパイルし、パーサーとクエリファイルを配置する。

各言語について以下の手順を実行する:

1. パーサーリポジトリをクローンし `tree-sitter build` でビルド
2. [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) の `runtime/queries/<lang>/` からクエリファイルをダウンロード

パーサーリポジトリのクエリは Neovim と互換性がないため、クエリファイルは nvim-treesitter から取得する。

```bash
# example: Go

# parser
git clone --depth=1 https://github.com/tree-sitter/tree-sitter-go /tmp/ts-go
cd /tmp/ts-go
tree-sitter build -o ~/.local/share/nvim/site/parser/go.so
rm -rf /tmp/ts-go

# queries
mkdir -p ~/.local/share/nvim/site/queries/go
cd ~/.local/share/nvim/site/queries/go
BASE=https://raw.githubusercontent.com/nvim-treesitter/nvim-treesitter/main/runtime/queries/go
curl -sLO $BASE/highlights.scm
curl -sLO $BASE/folds.scm
curl -sLO $BASE/indents.scm
curl -sLO $BASE/injections.scm
curl -sLO $BASE/locals.scm
```
