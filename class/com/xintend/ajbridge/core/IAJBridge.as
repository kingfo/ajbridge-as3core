package com.xintend.ajbridge.core {
	/**
	 * ...
	 * @author Kingfo[Telds longzang]
	 */
	public interface IAJBridge{
		
		function coreVersion(): String;
		
		/**
		 * 配置
		 * @param	loaderInfoParameters
		 */
		function deploy(flashvars: Object): void;
		
		function addCallback(...args): void;
		
		function sendEvent(event: Object): void ;
		
		function activate(config:Object = null): void;
		
		function getReady(): String;
		
	}

}