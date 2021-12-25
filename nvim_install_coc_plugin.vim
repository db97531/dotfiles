
function! Coc_InstallExtensions () abort

	" for json.
	CocInstall coc-json

	" for javascript and typescript.
	CocInstall coc-tsserver

	" for html, handlebars and razor.
	CocInstall coc-html

	" for css, scss and less.
	CocInstall coc-css

	" for vue, use vetur.
	CocInstall coc-vetur

	" for php, use intelephense-docs.
	CocInstall coc-phpls

	" for java, use eclipse.jdt.ls.
	CocInstall coc-java

	" for ruby, use solargraph.
	CocInstall coc-solargraph

	" for rust, use Rust Language Server
	CocInstall coc-rls

	" for yaml
	CocInstall coc-yaml

	" for python, extension forked from vscode-python.
	CocInstall coc-python

	" provide default document symbol highlight and colors support.
    "CocInstall coc-highlight

	" provide emmet suggest in completion list.
	"CocInstall coc-emmet

	" provide snippets solution.
	"CocInstall coc-snippets

endfunction
