set ts=2
set sw=2
set expandtab

" (Optional) Enable terraform plan to be include in filter
let g:syntastic_terraform_tf_filter_plan = 0

" (Optional) Default: 0, enable(1)/disable(0) plugin's keymapping
let g:terraform_completion_keys = 1

" (Optional) Default: 1, enable(1)/disable(0) terraform module registry completion
let g:terraform_registry_module_completion = 1
let g:terraform_fmt_on_save=1
