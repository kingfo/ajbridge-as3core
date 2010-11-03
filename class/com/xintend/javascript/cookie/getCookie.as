package com.xintend.javascript.cookie {
	/**
	 * ...
	 * @author Kingfo[Telds longzang]
	 */
	
	import com.xintend.javascript.ExternalInterfaceWarp;	
	import com.xintend.utils.isEmptyString;
	
	public function getCookie(name):* {
		if (isEmptyString(name)) return null;
		return ExternalInterfaceWarp.call("function (name){"
										+" var ret, m;"
										+" if ((m = document.cookie.match('(?:^| )' + name + '(?:(?:=([^;]*))|;|$)'))) {"
										+"  ret = m[1] ? decodeURIComponent(m[1]) : '';"
										+"   }"
										+" }"
										+"return ret;"
										+"}",name
										);
	}

}