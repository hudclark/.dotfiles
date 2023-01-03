(local ts-configs (require :nvim-treesitter.configs))
(local max-filesize (* 100 1024))

(ts-configs.setup {:sync_install false
                   :auto_install true
                   :highlight {:enable true
                               :addititional_vim_regex_highlighting false}})
