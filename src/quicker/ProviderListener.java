package quicker;

import java.util.EventListener;

public interface ProviderListener extends EventListener {
	public void afterUpdate(ProviderEvent pe);
	public void afterDelete(ProviderEvent pe);
	public void afterCreate(ProviderEvent pe);
}
