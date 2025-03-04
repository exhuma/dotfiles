" Vim syntax file
" Language: Changelog Processor
" Maintainer: Michel Albert
" Latest Revision: 2023-02-23

if exists("b:current_syntax")
  finish
endif

syn keyword clprocEntryType added changed security deprecated removed support fixed doc contained
syn region clprocDocMeta start='-\*-' end='-\*-' contained display contains=clprocDocMetaKey,clprocDocMetavalue
syn match clprocDocMetaKey "\(changelog-version\|release-nodes\|issue-url-template\|release-file\)" contained
syn match clprocDocMetaValue "\(\(changelog-version\|release-nodes\|issue-url-template\|release-file\): \)\@<=.\{-}\s" contained

" clproc 2.0 Columns
syn match clprocType ";\s\{-}[a-zA-Z]\+\s\{-};" transparent contains=clprocEntryType
syn match clprocVersion "^.\{-}\(\s\{-};\)\@="

syn match clprocComment "^#.*$" contains=clprocDocMeta

hi def link clprocEntryType Keyword
hi def link clprocDocMeta PreProc
hi def link clprocDocMetaKey Identifier
hi def link clprocDocMetaValue Constant
hi def link clprocComment Comment
hi def link clprocVersion Constant

let b:current_syntax = "clproc"
