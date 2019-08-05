--T1
--ods建表:pro.ods_yhzj_t_doctor_union_pack
--插入:mysql2hive.pack_t_doctor_union_pack到pro.ods_yhzj_t_doctor_union_pack
insert overwrite table pro.ods_yhzj_t_doctor_union_pack PARTITION(dt='${hivevar:preday}') 
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(unionId,'\\n|\\r','')) as unionId,
trim(regexp_replace(packName,'\\n|\\r','')) as packName,
trim(regexp_replace(packType,'\\n|\\r','')) as packType,
trim(regexp_replace(price,'\\n|\\r','')) as price,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(open,'\\n|\\r','')) as open,
trim(regexp_replace(description,'\\n|\\r','')) as description,
trim(regexp_replace(duration,'\\n|\\r','')) as duration,
trim(regexp_replace(count,'\\n|\\r','')) as count,
trim(regexp_replace(personal,'\\n|\\r','')) as personal,
trim(regexp_replace(askTimes,'\\n|\\r','')) as askTimes
from mysql2hive.pack_t_doctor_union_pack;


--T2
--ods建表:pro.ods_yhzj_t_order_session
--插入:mysql2hive.orders_t_order_session到pro.ods_yhzj_t_order_session
insert overwrite table pro.ods_yhzj_t_order_session PARTITION(dt='${hivevar:preday}') 
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(orderId,'\\n|\\r','')) as orderId,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(unionId,'\\n|\\r','')) as unionId,
trim(regexp_replace(patientId,'\\n|\\r','')) as patientId,
trim(regexp_replace(illCaseId,'\\n|\\r','')) as illCaseId,
trim(regexp_replace(doctorId,'\\n|\\r','')) as doctorId,
trim(regexp_replace(orderType,'\\n|\\r','')) as orderType,
trim(regexp_replace(askTimes,'\\n|\\r','')) as askTimes,
trim(regexp_replace(helpTimes,'\\n|\\r','')) as helpTimes,
trim(regexp_replace(packId,'\\n|\\r','')) as packId,
trim(regexp_replace(imGroupId,'\\n|\\r','')) as imGroupId,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(duration,'\\n|\\r','')) as duration,
trim(regexp_replace(startTime,'\\n|\\r','')) as startTime,
trim(regexp_replace(endTime,'\\n|\\r','')) as endTime,
trim(regexp_replace(mode,'\\n|\\r','')) as mode,
trim(regexp_replace(unionOwner,'\\n|\\r','')) as unionOwner
from mysql2hive.orders_t_order_session;


--T3
--ods建表:pro.ods_yhzj_t_prescription_detail
--插入:mysql2hive.drug_order_t_prescription_detail到pro.ods_yhzj_t_prescription_detail
insert overwrite table pro.ods_yhzj_t_prescription_detail PARTITION(dt='${hivevar:preday}') 
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(prescriptionId,'\\n|\\r','')) as prescriptionId,
trim(regexp_replace(drugId,'\\n|\\r','')) as drugId,
trim(regexp_replace(patients,'\\n|\\r','')) as patients,
trim(regexp_replace(periodNum,'\\n|\\r','')) as periodNum,
trim(regexp_replace(periodTime,'\\n|\\r','')) as periodTime,
trim(regexp_replace(times,'\\n|\\r','')) as times,
trim(regexp_replace(quantity,'\\n|\\r','')) as quantity,
trim(regexp_replace(method,'\\n|\\r','')) as method,
trim(regexp_replace(unit,'\\n|\\r','')) as unit,
trim(regexp_replace(number,'\\n|\\r','')) as number,
trim(regexp_replace(useDays,'\\n|\\r','')) as useDays,
trim(regexp_replace(remark,'\\n|\\r','')) as remark,
trim(regexp_replace(sortNumber,'\\n|\\r','')) as sortNumber
from mysql2hive.drug_order_t_prescription_detail;



--T4
--ods建表:pro.ods_yhzj_t_doctor_info
--插入:mysql2hive.pack_t_doctor_info到pro.ods_yhzj_t_doctor_info
insert overwrite table pro.ods_yhzj_t_doctor_info PARTITION(dt='${hivevar:preday}') 
select 
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(name,'\\n|\\r','')) as name,
trim(regexp_replace(headPic,'\\n|\\r','')) as headPic,
trim(regexp_replace(telephone,'\\n|\\r','')) as telephone,
trim(regexp_replace(title,'\\n|\\r','')) as title,
trim(regexp_replace(department,'\\n|\\r','')) as department,
trim(regexp_replace(hospitalId,'\\n|\\r','')) as hospitalId,
trim(regexp_replace(hospitalName,'\\n|\\r','')) as hospitalName,
trim(regexp_replace(hospitalLevel,'\\n|\\r','')) as hospitalLevel,
trim(regexp_replace(skill,'\\n|\\r','')) as skill,
trim(regexp_replace(titleRank,'\\n|\\r','')) as titleRank,
trim(regexp_replace(sex,'\\n|\\r','')) as sex,
trim(regexp_replace(qty,'\\n|\\r','')) as qty,
trim(regexp_replace(score,'\\n|\\r','')) as score,
trim(regexp_replace(authorityStatus,'\\n|\\r','')) as authorityStatus
from mysql2hive.pack_t_doctor_info;



--T5
--ods建表:pro.ods_yhzj_t_order
--插入:mysql2hive.orders_t_order到pro.ods_yhzj_t_order
insert overwrite table pro.ods_yhzj_t_order PARTITION(dt='${hivevar:preday}') 
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(number,'\\n|\\r','')) as number,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(totalAmount,'\\n|\\r','')) as totalAmount,
trim(regexp_replace(orderType,'\\n|\\r','')) as orderType,
trim(regexp_replace(merchantType,'\\n|\\r','')) as merchantType,
trim(regexp_replace(merchant,'\\n|\\r','')) as merchant,
trim(regexp_replace(status,'\\n|\\r','')) as status,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(finishTime,'\\n|\\r','')) as finishTime,
trim(regexp_replace(cancelTime,'\\n|\\r','')) as cancelTime,
trim(regexp_replace(remark,'\\n|\\r','')) as remark,
trim(regexp_replace(needPay,'\\n|\\r','')) as needPay
from mysql2hive.orders_t_order;



--T6
--ods建表:pro.ods_yhzj_t_ext_order
--插入:mysql2hive.orders_t_ext_order到pro.ods_yhzj_t_ext_order
insert overwrite table pro.ods_yhzj_t_ext_order PARTITION(dt='${hivevar:preday}') 
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(totalAmount,'\\n|\\r','')) as totalAmount,
trim(regexp_replace(orderId,'\\n|\\r','')) as orderId,
trim(regexp_replace(imGroupId,'\\n|\\r','')) as imGroupId,
trim(regexp_replace(srcOrderId,'\\n|\\r','')) as srcOrderId,
trim(regexp_replace(patientId,'\\n|\\r','')) as patientId,
trim(regexp_replace(extType,'\\n|\\r','')) as extType,
trim(regexp_replace(extPackName,'\\n|\\r','')) as extPackName,
trim(regexp_replace(packType,'\\n|\\r','')) as packType,
trim(regexp_replace(askTimes,'\\n|\\r','')) as askTimes,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(payTime,'\\n|\\r','')) as payTime,
trim(regexp_replace(status,'\\n|\\r','')) as status
from mysql2hive.orders_t_ext_order;



--T7
--ods建表:pro.ods_yhzj_t_charge_bill
--插入:mysql2hive.orders_t_charge_bill到pro.ods_yhzj_t_charge_bill
insert overwrite table pro.ods_yhzj_t_charge_bill PARTITION(dt='${hivevar:preday}') 
select 
trim(regexp_replace(id,'\\n|\\r','')) as id,
trim(regexp_replace(userId,'\\n|\\r','')) as userId,
trim(regexp_replace(patientId,'\\n|\\r','')) as patientId,
trim(regexp_replace(totalAmount,'\\n|\\r','')) as totalAmount,
trim(regexp_replace(orderId,'\\n|\\r','')) as orderId,
trim(regexp_replace(gid,'\\n|\\r','')) as gid,
trim(regexp_replace(msgId,'\\n|\\r','')) as msgId,
trim(regexp_replace(creator,'\\n|\\r','')) as creator,
trim(regexp_replace(createTime,'\\n|\\r','')) as createTime,
trim(regexp_replace(payTime,'\\n|\\r','')) as payTime,
trim(regexp_replace(status,'\\n|\\r','')) as status,
trim(regexp_replace(itemId,'\\n|\\r','')) as itemId,
trim(regexp_replace(itemName,'\\n|\\r','')) as itemName
from mysql2hive.orders_t_charge_bill;


--T8
--ods建表:pro.ods_yhzj_t_drug_order
--插入:mysql2hive.drug_order_t_drug_order到pro.ods_yhzj_t_drug_order
insert overwrite table pro.ods_yhzj_t_drug_order PARTITION(dt='${hivevar:preday}') 
select 
trim(regexp_replace(id ,'\\n|\\r','')) as  id ,
trim(regexp_replace(userId ,'\\n|\\r','')) as  userId ,
trim(regexp_replace(patientId ,'\\n|\\r','')) as  patientId ,
trim(regexp_replace(patientName ,'\\n|\\r','')) as  patientName ,
trim(regexp_replace(doctorId ,'\\n|\\r','')) as  doctorId ,
trim(regexp_replace(doctorName ,'\\n|\\r','')) as  doctorName ,
trim(regexp_replace(prescriptionId ,'\\n|\\r','')) as  prescriptionId ,
trim(regexp_replace(status ,'\\n|\\r','')) as  status ,
trim(regexp_replace(prescriptionUrl ,'\\n|\\r','')) as  prescriptionUrl ,
trim(regexp_replace(receiver ,'\\n|\\r','')) as  receiver ,
trim(regexp_replace(mobile ,'\\n|\\r','')) as  mobile ,
trim(regexp_replace(province ,'\\n|\\r','')) as  province ,
trim(regexp_replace(city ,'\\n|\\r','')) as  city ,
trim(regexp_replace(country ,'\\n|\\r','')) as  country ,
trim(regexp_replace(addrDetail ,'\\n|\\r','')) as  addrDetail ,
trim(regexp_replace(payType ,'\\n|\\r','')) as  payType ,
trim(regexp_replace(drugPrice ,'\\n|\\r','')) as  drugPrice ,
trim(regexp_replace(postFee ,'\\n|\\r','')) as  postFee ,
trim(regexp_replace(totalPrice ,'\\n|\\r','')) as  totalPrice ,
trim(regexp_replace(costPrice ,'\\n|\\r','')) as  costPrice ,
trim(regexp_replace(createTime ,'\\n|\\r','')) as  createTime ,
trim(regexp_replace(payTime ,'\\n|\\r','')) as  payTime ,
trim(regexp_replace(cancelTime ,'\\n|\\r','')) as  cancelTime ,
trim(regexp_replace(finishTime ,'\\n|\\r','')) as  finishTime ,
trim(regexp_replace(supplierName ,'\\n|\\r','')) as  supplierName 
from mysql2hive.drug_order_t_drug_order;