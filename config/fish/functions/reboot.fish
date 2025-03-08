function reboot --wraps=reboot --description 'alias reboot=reboot'
    topgrade
    sleep 5s
    command reboot
end
