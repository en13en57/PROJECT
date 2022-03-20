package PRO.S2K.CAMP.AUTH;

import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.oauth.OAuth20Service;

public class SnsLogin {
	private OAuth20Service oauthService;
	
	public SnsLogin(SnsValue sns) {
		this.oauthService = new ServiceBuilder(sns.getClientId())
								.apiSecret(sns.getClientSecret())
								.callback(sns.getRedirectUrl())
								.scope("profile")
								.build(sns.getApi20Instance());
	}

	public String getNaverAuthURL() {
		return this.oauthService.getAuthorizationUrl();
	}
}
