-- Inspired by https://github.com/po5/chapterskip/blob/master/chapterskip.lua
-- The above script was not robust enough. I often had to edit the `chapterskip.conf` when watching
-- something new because `Intro` could either mean the opening music video, or just the first part
-- of an episode.
--
-- This script instead adds a `chapter-skip` keybind. When performed, the chapter is skipped and
-- the title is recorded. From then on, any chapter with that title will be skipped (once).
--
-- TODO: A `chapter-unskip` keybind might also be useful

local chapters_skipped = {}
local chapters_to_skip = {}

function chapterskip(_, current)
    local chapters = mp.get_property_native("chapter-list")
    if current  == nil then return end
    if chapters == nil then return end

    local chapter = chapters[current + 1]
    if chapter == nil                      then return end
    if not chapters_to_skip[chapter.title] then return end
    if chapters_skipped[chapter.title]     then return end

    chapters_skipped[chapter.title] = true
    mp.commandv("add", "chapter", 1)
end

mp.add_key_binding("Ctrl+s", "chapter-skip",
    function()
        local chapters = mp.get_property_native("chapter-list")
        local chapter = mp.get_property_number("chapter")
        if chapter and chapters then
            chapters_to_skip[chapters[chapter + 1].title] = true
            chapters_skipped[chapters[chapter + 1].title] = true
        end
        mp.commandv("add", "chapter", 1)
    end)

mp.observe_property("chapter", "number", chapterskip)
mp.register_event("file-loaded", function() chapters_skipped = {} end)
