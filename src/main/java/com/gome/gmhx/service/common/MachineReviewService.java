package com.gome.gmhx.service.common;

import java.util.Map;

import com.gome.gmhx.entity.HxServiceProduct;

public interface MachineReviewService {
	
	
	// 恒信安装回执填单机器审核
	public String hxServiceBillMachineReview(String machineModeCode,String barCode,String hxNum,HxServiceProduct serviceProduct);
	
	// 金力安装回执条码校验接口使用
	public String JlOrCrmServiceBillOnceMachineReview(String machineModeCode,String barCode,String jlNum);
	
	// 金力安装回执进入恒信系统后机审
	public String JlOrCrmServiceBillTwiceMachineReview(String machineModeCode,String barCode,HxServiceProduct serviceProduct,String jlNum,String hxNum);
	
	public String machineRecevie(String serviceId);

	// 拆分机型为内外机型
	public Map<String,String> splitMachineCode(String category,String MachineCode,String brand);
	
	// 将内外机型转为整机机型
	public String mergeMachineCode(String category,String brand,String machineCode);
	
	// 校验条码是否在安装回执、维修回执、退换机中已使用1
	public String velidateBarCodeIsUsed(String barCode);
	
	// 校验条码是否在安装回执、维修回执、退换机中已使用2(剔除掉和本表单id相同的条码)
	public String velidateBarCodeIsUsed(String barCode,String customerId);
	
	// 校验条码规则
	public String velidateBarCodeRule(String machineModeCode,String barCode);
	
	// 恒信维修回执机审
	public String hxRepairBillMachineReview(String key);
}