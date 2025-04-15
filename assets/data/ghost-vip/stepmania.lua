function onCreatePost()
for i =0,3 do
noteTweenX('NoteX'..i,i,getPropertyFromGroup('strumLineNotes',i,'x')- 0,0.0,'linear')
noteTweenY('NoteY'..i,i,getPropertyFromGroup('strumLineNotes',i,'y')- 0,0.0,'linear')
end
for i = 0,7 do
setPropertyFromGroup('opponentStrums',i,'texture','noteSkins/Stepmania')
end
for n = 0,getProperty('unspawnNotes.length')-1 do
if getPropertyFromGroup('unspawnNotes',n,'isSustainNote') then
if getPropertyFromGroup('unspawnNotes',n,'mustPress') then
else
setPropertyFromGroup('unspawnNotes',n,'offsetX', getPropertyFromGroup('unspawnNotes',n,'offsetX'))
end
end
if getPropertyFromGroup('unspawnNotes',n,'mustPress') then
else
setPropertyFromGroup('unspawnNotes',n,'texture','noteSkins/Stepmania')
end
end
    
end