local status, notify = pcall(require, 'notify')
if (not status) then return end
notify.setup({
    background_colour='#000000',
})
