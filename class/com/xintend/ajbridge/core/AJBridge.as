package com.xintend.ajbridge.core {
	import com.xintend.events.RichEvent;
	import com.xintend.javascript.ExternalInterfaceWarp;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author Kingfo[Telds longzang]
	 */
	public class AJBridge extends EventDispatcher implements IAJBridge {
		
		
		public static const VERSION: String = "2.0.0";
		
		/**
		 * AJBridge 初始化完成
		 */
		public static const INIT: String = "init";
		/**
		 * AJBridge 添加方法。
		 */
		public static const ADD_CALLBACK: String = "addCallback";
		/**
		 * swf 准备完毕
		 */
		public static const SWF_READY: String = "swfReady";
		
		/**
		 * 获取 bridge 实例
		 */
		static public function get bridge():IAJBridge { return instance||=new AJBridge(); }
		
		/**
		 * 向外部通讯的接口。
		 * 默认是 callback
		 */
		public function get entry():String { return _entry; }
		/**
		 * 本身所在元素 id
		 */
		public function get id():String { return _id; }
		
		/**
		 * as3core 的 AJBridge 版本号
		 * @return
		 */
		public function coreVersion(): String { return VERSION; }
			
		
		
		public function AJBridge() {
			if (instance) throw Error("singleton class!");
			instance = this;
		}
		
		
		public function deploy(flashvars: Object): void {
			var richEvent: RichEvent;
			
			
			
			_entry = flashvars["jsEntry"] || "callback";
			
			//ExternalInterfaceWarp.marshallExceptions = true;
			
			_id = flashvars["swfID"] || ExternalInterfaceWarp.objectID || "noSWFID";
			
			
			richEvent = new RichEvent(INIT, false, true, { entry: entry, id: id } );
			dispatchEvent(richEvent);
			sendEvent(richEvent);
			
			addCallback(
						"activate", activate,
						"getReady", getReady,
						"coreVersion",coreVersion
						);
		}
		
		public function addCallback(...args): void {
			var len: int = args.length;
			var richEvent: RichEvent;
			var name: String;
			var func: Function;
			var funcList: Array = [];
			var callbacks: * ;
			if (len == 1) {
					callbacks = args[0];
					for (name in callbacks) {
						func = callbacks[name] as Function;
						if (func == null) continue;
						funcList.push(name);
						ExternalInterfaceWarp.addCallback(name, func);
					}
				
			}else if (len > 1) {
				while (args.length) {
					callbacks = args.splice(0, 2);
					name = callbacks[0];
					func = callbacks[1];
					funcList.push(name);
					ExternalInterfaceWarp.addCallback(name, func);
				}
			}else {
				return ;
			}
			
			richEvent = new RichEvent(ADD_CALLBACK, false, true, { entry: entry, id: id, funcList: funcList } );
			dispatchEvent(richEvent);
			sendEvent(richEvent);
		}
		/**
		 * 向外部发送自定义事件
		 * @param	event
		 */
		public function sendEvent(event: Object): void {
			if (_entry == null || _entry == "" || _id == null || _id == "") {
				trace("未初始化AJBridge,请在执行前调用AJBridge.deploy();");
			}
			if (ExternalInterfaceWarp.available) {
				ExternalInterfaceWarp.call(_entry,_id,event);
			}
		}
		/**
		 * 
		 * 也可用于静态发布 swf 方式的激活
		 * @param	config
		 */
		public function activate(config: Object = null): void {
			var richEvent: RichEvent;
			if (config) {
				_entry = config.jsEntry || _entry;
				_id = config.swfID || _id;
			}
			richEvent = new RichEvent(SWF_READY, false, true, { entry: entry, id: id });
			dispatchEvent(richEvent);
			sendEvent(richEvent);
		}
		
		/**
		 * 恒等于  ready  用于外部检测
		 * @return
		 */
		public function getReady(): String {
			return "ready";
		}
		
		
		private var _entry: String;
		private var _id: String;
		
		
		protected static var instance: IAJBridge;
	}

}