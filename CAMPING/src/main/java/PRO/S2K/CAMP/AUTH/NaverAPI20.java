package PRO.S2K.CAMP.AUTH;

import com.github.scribejava.core.builder.api.DefaultApi20;

public class NaverAPI20 extends DefaultApi20 implements SnsUrls  {
	private NaverAPI20() {
	}
	
	private static class InstanceHolder { // 인스턴스 홀더를 이용한 싱글
		private static final NaverAPI20 INSTANCE = new NaverAPI20();
	}
	public static NaverAPI20 instance() {
			return InstanceHolder.INSTANCE;
	}
	@Override
	public String getAccessTokenEndpoint() {
		return NAVER_ACCESS_TOKEN;
	}
	@Override
	protected String getAuthorizationBaseUrl() {
		return NAVER_AUTH;
	}
}
