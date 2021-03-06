<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../../inc/header.jsp"%>
<%@ include file="../../inc/resource.inc"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<script type="text/javascript">
		var dataGrid;
		$(function() {
			dataGrid = $('#dataGrid').datagrid({
				title : "配件资料",
				url : "${ctx}/hxFitting/getHxFittingPageList",
				striped : true,
				collapsible : true,
				autoRowHeight : false,
				remoteSort : false,
				rownumbers : true,
				fitColumns : true,
				pagination : true,
				singleSelect : true,
				height : document.body.clientHeight *0.7,
				queryParams : {
					pageNo : 1,
					pageCount : 20
				},
				columns : [ [ {
					field : 'fitting_code',
					title : '配件编码',
					align:'center',
					width : 40
				}, {
					field : 'fitting_name',
					title : '配件名称',
					align:'center',
					width : 40
				}, {
					field : 'fitting_type',
					title : '配件分类',
					align:'center',
					width : 30
				}, {
					field : 'parts_code',
					title : '部品号',
					align:'center',
					width : 40
				}, {
					field : 'spec',
					title : '规格',
					align:'center',
					width : 40
				}, {
					field : 'produce_type',
					title : '生产类型',
					align:'center',
					width : 30
				}, {
					field : 'gome_code',
					title : '国美代码',
					align:'center',
					width : 40
				}, {
					field : 'brand',
					title : '品牌',
					align:'center',
					width : 40
				}, {
					field : 'fitting_level',
					title : '物料级别',
					align:'center',
					width : 30
				}, {
					field : 'network_price',
					title : '网点价格',
					align:'center',
					width : 30
				}, {
					field : 'user_price',
					title : '用户价格',
					align:'center',
					width : 30
				}, {
					field : 'term',
					title : '保修期限',
					align:'center',
					width : 30
				}, {
					field : 'is_retrieve',
					title : '是否回收',
					align:'center',
					formatter : function(value, row, index) {
						if(value == 1){
				  			return '<image src="${ctx}/images/icons/ok.png">';
				  		}else if(value == 0){
				  			return '<image src="${ctx}/images/icons/cancel.png">';
				  		}else{
				  			return '';
				  		}
				  	},
					width : 30
				}, {
					field : 'is_stop',
					title : '是否停用',
					align:'center',
					formatter : function(value, row, index) {
						if(value == 1){
				  			return '<image src="${ctx}/images/icons/ok.png">';
				  		}else if(value == 0){
				  			return '<image src="${ctx}/images/icons/cancel.png">';
				  		}else{
				  			return '';
				  		}
				  	},
					width : 30
				}, {
					field : 'update_time',
					title : '更新日期',
					align:'center',
					width : 50
				}, {
					field : 'action',
					title : '操作',
					align:'center',
					width : 50,
					formatter : function(value, row, index) {
						if("${sessionScope.user.sysPositionType}"!=1){
							return '<a href="#" onclick="view(\'' + row.fitting_code + '\');">查看</a>';
						}
						return '<a href="#" onclick="view(\'' + row.fitting_code + '\');">查看</a> <a href="#" onclick="update(\'' + row.fitting_code + '\');">修改</a>';
					}
				} ] ],
				toolbar : '#toolbar',
				onLoadSuccess : function() {
					$('#searchForm table').show();
					$(this).datagrid('doCellTip',{'max-width':'300px','delay':500});
					parent.$.messager.progress('close');
				}
			});
			$('.datagrid-pager').pagination({
				pageSize: 20,//每页显示的记录条数，默认为10 
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
				var obj = $.serializeObject($('#searchForm'));
				obj.suitModel = $("#suitModel").combo("getText");
				dataGrid.datagrid('load', obj);
			});
			
			$('#class1').combobox({
				url: "${ctx}/eccGoods/getGoodClass?classification=1",
				valueField:'value', 
				textField:'text',
				onChange:function(record){  
					$('#class2').combobox({
						url: "${ctx}/eccGoods/getGoodClass?classification=2&upperCode="+$('#class1').combobox('getValue'),
						valueField:'value', 
						textField:'text',
						onChange:function(record){
				        	$('#class3').combobox({
								valueField:'value', 
								textField:'text',
								url: "${ctx}/eccGoods/getGoodClass?classification=3&upperCode="+$('#class2').combobox('getValue'),
								onChange:function(record){
						        	$('#fittingType').combobox({
						        		url: "${ctx}/eccGoods/getGoodClass?classification=4&upperCode="+$('#class3').combobox('getValue'),
										valueField:'value', 
										textField:'text',
									});
						        	$("#fittingType").combobox("clear");
					         	} 
							});
				        	$("#class3").combobox("clear");
				        	$("#fittingType").combobox("clear");
			         	} 
					});
		        	$("#class2").combobox("clear");
		        	$("#class3").combobox("clear");
		        	$("#fittingType").combobox("clear");
		     	} 
			}); 
			
		});
		$.serializeObject = function(form) {
			var o = {
				pageNo : 1,
				pageCount : 20
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
		
		function update(fittingCode){
			window.location.href = "${ctx}/hxFitting/updateView/" + fittingCode;
		}
		
		function view(fittingCode){
			var pageMarkup = "hxFittingList";
			window.location.href = "${ctx}/hxFitting/viewHxFitting/" + fittingCode+"/"+pageMarkup;
		}
	
		function refreshDataGrid() {
			$('#dataGrid').datagrid("reload");
			parent.$.modalDialog.handler.dialog('close');	
		}
		
		function add(){
			window.location.href = "${ctx}/hxFitting/addView";
		}
		
		function importFitting(){
			parent.$.modalDialog({
				title : '配件数据导入',
				width : 400,
				height :250,
				closable : false,
				href : '${ctx}/common/import/importData?templateName=fitting&actionName=importHxFitting',
				buttons : [ 
				{
					text : '关闭',
					handler : function() {
						parent.$.modalDialog.handler.dialog('close');
					}
				}]
			});
		}
		
		function importSuitModel() {
			parent.$.modalDialog({
				title : '适用机型数据导入',
				width : 400,
				height :250,
				closable : false,
				href : '${ctx}/common/import/importData?templateName=suitmodel&actionName=importHxFittingModel',
				buttons : [ 
				{
					text : '关闭',
					handler : function() {
						parent.$.modalDialog.handler.dialog('close');
					}
				}]
			});
		}
		
		function importFaultCode() {
			parent.$.modalDialog({
				title : '故障代码数据导入',
				width : 400,
				height :250,
				closable : false,
				href : '${ctx}/common/import/importData?templateName=fittingfaultcode&actionName=importHxFittingFaultCode',
				buttons : [ 
				{
					text : '关闭',
					handler : function() {
						parent.$.modalDialog.handler.dialog('close');
					}
				}]
			});
		}
		
	</script>
</head>
<body>
	<div class="easyui-layout" data-options="fit:true,border:false">
		<div data-options="region:'north',title:'查询条件',border:false,collapsible:false" style="height: 260px; overflow: hidden;;">
			<form id="searchForm">
				<table class="table table-hover table-condensed" style="width:100%; padding: 7px 80px 0px 80px">
				    <tr>
				       <td width="5%">一级分类</td>
			           <td width="5%"><input id="class1" type="text"  class="easyui-combobox"/></td>
			           <td width="5%"></td>
			           <td width="5%">二级分类</td>
			           <td width="5%"><input id="class2" type="text"  class="easyui-combobox"></td>
			           <td width="5%"></td>
			           <td width="5%">三级分类</td>
			           <td width="5%"><input id="class3" type="text"  class="easyui-combobox"></td>
			           <td width="5%"></td>
					   <td width="55%"></td>
				    </tr>
					<tr>
					    <td width="5%">配件分类:</td>
						<td width="5%"><input class="easyui-combobox" name="fittingType" id="fittingType"/></td>
						<td width="5%"></td>
						<td width="5%">配件编码:</td>
						<td width="5%"><input name="fittingCode" placeholder="输入查询条件"/></td>
						<td width="5%"></td>
						<td width="5%">配件名称:</td>
						<td width="5%"><input name="fittingName" placeholder="输入查询条件"/></td>
						<td width="5%"></td>
						<td width="55%"></td>
					</tr>
					<tr>
						<td width="5%">部品号:</td>
						<td width="5%"><input name="partsCode" placeholder="输入查询条件"/></td>
						<td width="5%"></td>
						<td width="5%">规格:</td>
						<td width="5%"><input name="spec" placeholder="输入查询条件"/></td>
						<td width="5%"></td>
						<td width="5%">生产类型:</td>
						<td width="5%"><input class="easyui-combobox" name="produceType" data-options="url:'${ctx}/hxCode/getCombobox/sclx', editable:false"/></td>
						<td width="5%"></td>
						<td width="55%"></td>
					</tr>
					<tr>
						<td width="5%">国美代码:</td>
						<td width="5%"><input class="easyui-combobox" name="gomeCode" data-options="url:'${ctx}/hxCode/getCombobox/gmdm', editable:false"/></td>
						<td width="5%"></td>
						<td width="5%">品牌:</td>
						<td width="5%"><input class="easyui-combobox" name="brand" data-options="url:'${ctx}/hxCode/getCombobox/pp', editable:false"/></td>
						<td width="5%"></td>
						<td width="5%">物料级别:</td>
						<td width="5%"><input class="easyui-combobox" name="fittingLevel" data-options="url:'${ctx}/hxCode/getCombobox/wljb', editable:false"/></td>
						<td width="5%"></td>
						<td width="55%"></td>
					</tr>
					<tr>
						<td width="5%">是否回收:</td>
						<td width="5%"><input class="easyui-combobox" name="isRetrieve" data-options="url:'${ctx}/hxCode/getCombobox/sf', editable:false"/></td>
						<td width="5%"></td>
						<td width="5%">是否停用:</td>
						<td width="5%"><input class="easyui-combobox" name="isStop" data-options="url:'${ctx}/hxCode/getCombobox/sf', editable:false"/></td>
						<td width="5%"></td>
						<td width="5%">适用机型:</td>
						<td width="5%"><input class="easyui-combobox" id="suitModel" name="suitModel" data-options="url:'${ctx}/hxCode/getCombobox/jx'"/></td>
						<td width="5%"></td>
						<td width="55%"></td>
					</tr>
					<tr>
						<td width="5%">更新日期:</td>
						<td width="25%">
							<input id="ksrq" placeholder="选择起始日期" class="Wdate" name="ksrq" type="text" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'jsrq\')}'})"/>至
							<input id="jsrq" placeholder="选择结束日期" class="Wdate" name="jsrq" type="text" onFocus="WdatePicker({minDate:'#F{$dp.$D(\'ksrq\')}'})"/> 
						</td>
						<td width="5%"></td>
						<td width="5%"></td>
						<td width="5%"><a href="#" id="query" class="easyui-linkbutton" iconCls="icon-search">查询</a></td>
						<td width="5%"></td>
					</tr>
				</table>
			</form>
		</div>
		<div id="toolbar" style="display: none;">
			<a href="javascript:void(0);" class="easyui-linkbutton"
				data-options="iconCls:'icon-add',plain:true" onclick="add();">增加</a>
			<a href="javascript:void(0);" class="easyui-linkbutton"
				data-options="iconCls:'icon-excel',plain:true" onclick="importFitting();">配件导入</a>
			<a href="javascript:void(0);" class="easyui-linkbutton"
				data-options="iconCls:'icon-excel',plain:true" onclick="importSuitModel();">适用机型导入</a>
			<a href="javascript:void(0);" class="easyui-linkbutton"
				data-options="iconCls:'icon-excel',plain:true" onclick="importFaultCode();">故障代码导入</a>
		</div>
		<div data-options="region:'center',border:false">
			<table id="dataGrid"></table>
		</div>
	</div>
</body>
</html>
