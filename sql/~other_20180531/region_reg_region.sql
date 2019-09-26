select rr.*
from reg_region rr
  inner join reg_operator ro on rr.ropID = ro.ropID
where rr.isGSM = 1
  and exists (
    select 1  
    from reg_region r
      inner join reg_operator o on r.ropID = o.ropID
    where r.Prefix = rr.Prefix
      and o.rcID = ro.rcID
      and r.regID != rr.regID        
      and r.isGSM = 1
      and r.RangeStart between rr.RangeStart and rr.RangeEnd)
order by ro.rcID, rr.Prefix