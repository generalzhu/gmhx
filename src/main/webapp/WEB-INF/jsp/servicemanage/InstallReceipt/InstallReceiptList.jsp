<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../../inc/header.jsp"%>
<%@ include file="../../inc/resource.inc"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<style type="text/css">
td {white-space: nowrap;}
</style>
<script type="text/javascript">
		var dataGrid;
		$(function(){
			onStart(document.body.clientHeight - 160);
			$('#dataGrid').datagrid('cancelCellTip');
			$('#dataGrid').datagrid('doCellTip',{'max-width':'300px'});
			
			$(".combo").attr("style","width: 85%; height: 20px;" );
	    	$(".combo-text").attr("style","width: 85%; height: 20px; line-height: 20px;" );
	    	$(".combo-panel").attr("style","width: 100%; height: auto;" );
		});
		
		function clos(){
			onStart(document.body.clientHeight - 28);
			$('#dataGrid').datagrid('cancelCellTip');
			$('#dataGrid').datagrid('doCellTip',{'max-width':'300px'});
		}
		
		function ope(){
			onStart(document.body.clientHeight - 160);
			$('#dataGrid').datagrid('cancelCellTip');
			$('#dataGrid').datagrid('doCellTip',{'max-width':'300px'});
		}
		
		function onStart(heigh){
		 	dataGrid = $('#dataGrid').datagrid({
				title : "安装服务单",
				url : "${ctx}/installReceipt/getInstallReceiptPageList",
				striped : true,
	            height : heigh,
	            collapsible : true,
	            autoRowHeight : false,
	            remoteSort : false,
	            idField : 'service_id',
	            rownumbers : true,
	            fitColumns : true,
	            nowrap : true,
	            pagination : true,
	            checkOnSelect : false,
	            selectOnCheck : false,
	            queryParams : {
	                currentPage : 1,
	                pageCount : 10
	            },
				columns : [ [ 
				   {field : 'service_id',title : '安装单号', width : 10 ,align:'center'
				}, {field : 'machine_type',title : '机型', width : 10,align:'center'
				}, {field : 'gome_code',title : '国美代码', width : 10,align:'center'
				}, {field : 'brand',title : '品牌', width : 10,align:'center'
				}, {field : 'machine_code',title : '机器条码(非调)', width : 10,align:'center'
				}, {field : 'internal_machine_code1',title : '内机条码', width : 10,align:'center'
				}, {field : 'delivery_order_num',title : '提货单号', width : 10,align:'center'
				}, {field : 'ticket_num',title : '单据序号', width : 10,align:'center'
				}, {field : 'customer_name',title : '客户姓名', width : 10,align:'center'
				}, {field : 'service_status',title : '状态',align:'center',
					formatter:function(value, row, index){ 
                	return statusVal(row.service_status);
                }
				}, {field : 'create_organization_s',title : '创建机构', width : 10,align:'center'
				}, {field : 'create_time_s',title : '创建时间', width : 10,align:'center'
				}, {field : 'install_unit',title : '安装单位', width : 20,align:'center'
				}, {field : 'install_date',title : '安装日期', width : 16,align:'center'
				}, {field : 'action',title : '操作', width : 13,align:'center',
					formatter : function(value, row, index) {
						if(row.service_status=="S1"){
							return '<a href="#" onclick="checkTicket(\'' + row.service_id + '\');">查看</a>|<a href="#" onclick="updateTicket(\'' 
							+ row.service_id + '\');">修改</a>|<a href="#" onclick="del(\'' + row.service_id + '\');">删除</a>';
						}else{
							return '<a href="#" onclick="checkTicket(\'' + row.service_id + '\');">查看</a>';
						}
					}
				} ] ],
				toolbar : '#toolbar',
				onLoadSuccess : function() {
					$('#searchForm table').show();
					parent.$.messager.progress('close');
				}
			});
			$('.datagrid-pager').pagination({
				pageSize: 20,         
				onSelectPage : function(pageNumber, pageSize) {
					$(this).pagination('loading');
					var queryParams = $.serializeObject($('#searchForm'));
					queryParams.currentPage = pageNumber;
					queryParams.pageCount = pageSize;
					$('#dataGrid').datagrid("options").queryParams = queryParams;
					$('#dataGrid').datagrid("reload");
					$(this).pagination('loaded');
				}
			});
			$("#query").on("click", function() {
				dataGrid.datagrid('load', $.serializeObject($('#searchForm')));
			});
		};
	 
		$.serializeObject = function(form) {
			var o = {
				currentPage : 1,
				pageCount : 10
			};
			$.each(form.serializeArray(), function(index) {
				if (o[this['name']]) {
					o[this['name']] = o[this['name']] + "," + this['value'];
				} else {
					o[this['name']] = this['value'];
				}
			});
			return o;
		};
	
		function checkTicket(serviceId){
			window.location.href="${ctx}/installReceipt/installReceiptView/"+ serviceId ;
		}
		
		function updateTicket(installNum){
			var Id = $("#Id").val();
			window.location.href="${ctx}/installReceipt/updateInstallReceiptView/"+ installNum;
		}
		
		function del(serviceId){
			parent.$.messager.confirm('提示', '确认要删除么？', function(r){
				if (r){
					$.post("${ctx}/installReceipt/deleteInstallReceipt/"+serviceId,
						function(msg){
						if($.parseJSON(msg).flag == "success"){
							$.messager.alert('提示:','删除成功!');
							$('#dataGrid').datagrid("reload");
						}else{
							$.messager.alert('提示:','删除失败!');
						}
					});
				}
			});
		}
		
		function refreshDataGrid() {
			$('#dataGrid').datagrid("reload");
			parent.$.modalDialog.handler.dialog('close');	
		}	
		
		function add(){
			window.location.href = "${ctx}/installReceipt/addview";
		}
		
		function statusVal(status) {
			if (status == 'S0') {
				return '流程结束';
			} else if (status == 'S1') {
				return '暂存';
			} else if (status == 'S2') {
				return '提交';
			} else if (status == 'S3') {
				return '分部审核';
			} else if (status == 'S4') {
				return '总部审核';
			} else if (status == 'S5') {
				return '填写出库数量';
			} else if (status == 'S6') {
				return '出库';
			} else if (status == 'S7') {
				return '邮包发货';
			} else if (status == 'S8') {
				return '邮包收货';
			} else if (status == 'S9') {
				return '网店确认';
			}else if(status=='S10'){
				return "退回修改";
			}else if(status=='S11'){
				return "发货";
			}else if(status=='S12'){
				return "收货";
			}else if(status=='S13'){
				return "检测";
			}else if(status=='S14'){
				return "入库";
			}else if(status=='S15'){
				return "移库";
			}
		}
		
</script>
</head>
<body>
	<div class="easyui-layout" data-options="fit:true,border:false">
		<div data-options="region:'north',title:'查询条件',border:false,collapsible:true,onBeforeCollapse:function(){clos();},onBeforeOpen:function(){ope();}"  style="height: 160px; overflow: hidden;">
			<form id="searchForm">
				<table class="table table-hover table-condensed" width="100%;" style="padding:10px 10px 10px 10px">
					<tr>
						<td width="8%">安装单号</td>
						<td width="12%"><input style="width:85%" name="serviceTicket.serviceId" placeholder="请输入查询条件" class="span2" ></td>
						<td width="8%">机型</td>
						<td width="12%"><input style="width:85%" name="serviceProduct.machineType" placeholder="请输入查询条件" class="span2" ></td>
						<td width="8%">国美代码</td>
						<td width="12%"><input name="serviceProduct.gomeCode"  placeholder="请输入查询条件" class="easyui-combobox"  data-options="url:'${ctx}/hxCode/getCombobox/gmdm',panelHeight:'auto',editable:false "></td>
						<td width="8%">品牌</td>
						<td width="12%"><input name="serviceProduct.brand"  placeholder="请输入查询条件" class="easyui-combobox" class="span2" data-options="url:'${ctx}/hxCode/getCombobox/pp',panelHeight:'auto',editable:false "></td>
						<td width="8%">提货单号</td>
						<td width="12%"><input style="width:85%" name="serviceProduct.deliveryOrderNum"  placeholder="请输入查询条件" class="span2" ></td>
					</tr>
					<tr>
						<td>单据序号</td>
						<td><input style="width:85%" name="serviceProduct.ticketNum"  placeholder="请输入查询条件" class="span2" ></td>
						<td>外机条码(空调)</td>
						<td><input style="width:85%" name="serviceProduct.externalMachineCode"  placeholder="请输入查询条件" class="span2" ></td>
						<td>内机条码1(空调)</td>
						<td><input style="width:85%" name="serviceProduct.internalMachineCode1"  placeholder="请输入查询条件" class="span2" ></td>
						<td>内机条码2(空调)</td>
						<td><input style="width:85%" name="serviceProduct.internalMachineCode2"  placeholder="请输入查询条件" class="span2" ></td>
						<td>机器条码</td>
						<td><input style="width:85%" name="serviceProduct.machineCode"  placeholder="请输入查询条件" class="span2" ></td>
				    </tr>
					<tr>
						<td>客户姓名</td>
						<td><input style="width:85%" name="serviceCustomer.customerName"  placeholder="请输入查询条件" class="span2" ></td>
						<td>客户电话</td>
						<td><input style="width:85%" name="serviceCustomer.phone"  placeholder="请输入查询条件" class="span2" ></td>
						<td>状态</td>
						<td><input name="serviceTicket.serviceStatus"  placeholder="请输入查询条件" class="easyui-combobox"  data-options="url:'${ctx}/hxCode/getCombobox/hzzt',panelHeight:'auto',editable:false "></td>
						<td>创建人</td>
						<td><input style="width:85%" name="serviceTicket.createManS"  placeholder="请输入查询条件" class="span2" ></td>
						<td>创建机构</td>
						<td><input style="width:85%" name="serviceTicket.createOrganizationS"  placeholder="请输入查询条件" class="span2" ></td>
					</tr>
					<tr>
						<td>机型分类</td>
						<td><input style="width:85%" id="serviceProduct.machineType"  placeholder="请输入查询条件" class="span2" ></td>
						<td>安装单位</td>
						<td><input style="width:85%" name="serviceProduct.installUnit"  placeholder="请输入查询条件" class="span2" ></td>
						<td width="8%">创建时间</td>
						<td width="12%">
							<input style="width:38%" id="ksrq" placeholder="起始日期" class="Wdate" name="mod_createTime_st" type="text" readonly="readonly"  onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'jsrq\')}'})"/>-
							<input style="width:38%" id="jsrq" placeholder="结束日期" class="Wdate" name="mod_createTime_end" type="text" readonly="readonly"  onFocus="WdatePicker({minDate:'#F{$dp.$D(\'ksrq\')}'})"/> 
						</td>
						<td width="8%">安装日期</td>
						<td width="12%">
							<input style="width:38%" id="iksrq" placeholder="起始日期" class="Wdate" name="mod_installDate_st" type="text" readonly="readonly"  onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'ijsrq\')}'})"/>-
							<input style="width:38%" id="ijsrq" placeholder="结束日期" class="Wdate" name="mod_installDate_end" type="text" readonly="readonly"  onFocus="WdatePicker({minDate:'#F{$dp.$D(\'iksrq\')}'})"/> 
						</td>
						<td></td>
						<td align="center"><a href="#" id="query" class="easyui-linkbutton">查询</a></td>
					</tr>
				</table>
			</form>
		</div>
		<div class="easyui-layout" data-options="fit:true,border:false">
			<div id="toolbar" style="display: "";">
				<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="add();">增加</a>
			</div>
		</div>
		<div data-options="region:'center',border:false">
			<table id="dataGrid"></table>
		</div>
	</div>
</body>
</html>