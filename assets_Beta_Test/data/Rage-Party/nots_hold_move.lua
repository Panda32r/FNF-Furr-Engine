function onUpdatePost()
  --setProperty ('holdCoverBlue.x', getPropertyFromClass('Nots','offsetX'))

    if curStep == 135 then
      setProperty('holdCoverBlue_op.x',420)
      setProperty('holdCoverPurple_op.x',310)
      setProperty('holdCoverGreen_op.x',535)
      setProperty('holdCoverRed_op.x',645)
    end
    if curStep == 218 then
      doTweenX('TweenholdCoverBlue_op', 'holdCoverBlue_op',95, 0.5,'quintInOut')
      doTweenX('TweenholdCoverPurple_op', 'holdCoverPurple_op',-10, 0.5,'quintInOut')
      doTweenX('TweenholdCoverGreen_op', 'holdCoverGreen_op',210, 0.5,'quintInOut')
      doTweenX('TweenholdCoverRed_op', 'holdCoverRed_op',320, 0.5,'quintInOut')
    end  
    if difficultyName ~= 'Easy' then
    if curStep == 432 then
      setProperty('holdCoverBlue_op.x',420)
      setProperty('holdCoverPurple_op.x',310)
      setProperty('holdCoverGreen_op.x',535)
      setProperty('holdCoverRed_op.x',645)
      setProperty('holdCoverBlue.x',420)
      setProperty('holdCoverPurple.x',310)
      setProperty('holdCoverGreen.x',535)
      setProperty('holdCoverRed.x',645)
    end
    if curStep == 816 then
      setProperty('holdCoverBlue_op.x',95)
      setProperty('holdCoverPurple_op.x',-10)
      setProperty('holdCoverGreen_op.x',210)
      setProperty('holdCoverRed_op.x',320)
      setProperty('holdCoverBlue.x',735)
      setProperty('holdCoverPurple.x',625)
      setProperty('holdCoverGreen.x',850)
      setProperty('holdCoverRed.x',960)
    end
    if curStep == 1088 then
      setProperty('holdCoverBlue_op.x',420)
      setProperty('holdCoverPurple_op.x',310)
      setProperty('holdCoverGreen_op.x',535)
      setProperty('holdCoverRed_op.x',645)
      setProperty('holdCoverBlue.x',420)
      setProperty('holdCoverPurple.x',310)
      setProperty('holdCoverGreen.x',535)
      setProperty('holdCoverRed.x',645)
    end
    if curStep == 1370 then
      setProperty('holdCoverBlue_op.x',95)
      setProperty('holdCoverPurple_op.x',-10)
      setProperty('holdCoverGreen_op.x',210)
      setProperty('holdCoverRed_op.x',320)
      setProperty('holdCoverBlue.x',735)
      setProperty('holdCoverPurple.x',625)
      setProperty('holdCoverGreen.x',850)
      setProperty('holdCoverRed.x',960)
    end
    if curStep == 1600 then
      setProperty('holdCoverBlue_op.x',420)
      setProperty('holdCoverPurple_op.x',310)
      setProperty('holdCoverGreen_op.x',535)
      setProperty('holdCoverRed_op.x',645)
      setProperty('holdCoverBlue.x',420)
      setProperty('holdCoverPurple.x',310)
      setProperty('holdCoverGreen.x',535)
      setProperty('holdCoverRed.x',645)
    end
    if curStep == 1920 then 
      setProperty('holdCoverBlue_op.x',95)
      setProperty('holdCoverPurple_op.x',-10)
      setProperty('holdCoverGreen_op.x',210)
      setProperty('holdCoverRed_op.x',320)
      setProperty('holdCoverBlue.x',735)
      setProperty('holdCoverPurple.x',625)
      setProperty('holdCoverGreen.x',850)
      setProperty('holdCoverRed.x',960)
    end
  end
end
