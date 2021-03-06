package com.gome.gmhx.service.servicemanage.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.gome.common.page.Page;
import com.gome.gmhx.dao.hxhistory.HxHistoryData;
import com.gome.gmhx.service.servicemanage.HxHistoryTicketService;

/** 
 * @author 作者:wanghaojie
 * @date 创建时间：2015年1月12日 上午10:32:30 
 * @version 1.0 
 * @parameter  
 * @since  
 * @return  
 */
@Service("hxHistoryTicketService")
public class HxHistoryTicketServiceImpl implements HxHistoryTicketService {
	@Resource(name="hxHistoryDataImpl")
	HxHistoryData hxHistoryDataImpl;
	
	@Override
	public List<Map<String, Object>> getHistoryTicketPageList(Page page) {
		return hxHistoryDataImpl.getHistoryTicketPageList(page);
	}

	@Override
	public Map<String, Object> getServiceTicketById(String serviceId) {
		return hxHistoryDataImpl.getHistoryTicketById(serviceId);
	}

	
}
