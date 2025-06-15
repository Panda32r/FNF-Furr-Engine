function onCreatePost()
    for i = 0, getProperty('playerStrums.length')-1 do
            setPropertyFromGroup('playerStrums', i, 'texture', 'NOTE_assets_Lycur');
    end
    for i = 0, getProperty('unspawnNotes.length')-1 do
            if getPropertyFromGroup('unspawnNotes', i, 'mustPress') == true then
                    setPropertyFromGroup('unspawnNotes', i, 'texture','NOTE_assets_Lycur');
            end      
    end
end
