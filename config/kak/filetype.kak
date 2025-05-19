hook global BufCreate .*\.fsc %{ set-option buffer filetype fish }
hook global BufCreate .*\.gsh %{ set-option buffer filetype fish }

