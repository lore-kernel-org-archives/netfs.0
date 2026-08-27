Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18036389453
	for <netfs@lists.linux.dev>; Thu, 27 Aug 2026 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787857403; cv=none; b=p+eZISvRzrZAI8BN1lfBJGoIgjT8J9kpYnC9KCLdLtaXH3E3/Jalm1FK/an70belmP/XMocZ7Mi60gmv6k3zi/EO5+5yVXXOLvYLFlf/xszzRys+nMvtvqk8e6NWvVekZBSDXziTzr8Ohk3FIpnrXT7fjbv5h7TB30xnANzSNLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787857403; c=relaxed/simple;
	bh=dA5pULK5njbrA8f9ExeMOwkigYCPIWdfakRGcPE8X1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cB4Lg0gvOsOyDu+MJTcbDuSNqUwmRIFUbXgs7MbzhsvQNQx6Q/r3BoQiZ7ffh07x6TcyH2zhhNv3IW2v+5Da2ODHL02onCcY05EZsw6O1hLkwrAqJVrcP2H9mocDiAojf5tTmwYWvrzNmKJuNJd5Lgj5OZieyEM15P0fixS8YfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WAOHJwIQ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=M6Q9vAbf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WAOHJwIQ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="M6Q9vAbf"
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	by smtp-out1.suse.de (Postfix) with ESMTP id 2B77C21B90;
	Thu, 27 Aug 2026 19:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1787857394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xhUMft8JC1hXhIqq93oHYKOdEmHvveMSg/nGtCULBVE=;
	b=WAOHJwIQX9v36rvkU7b52BcDwb7rxq0N9F9Y6NJXjJka1RvTfjjsgBmN5EgGzcFwV/aS8Z
	SbqcgN+XZbHVlyIJNmiIqgpt864/Ye4OQgY6MkT+LtGoqxZBriiAvva6z8QV7vkK+pPeih
	o2dCG1XiBd6mihZr0uUXJX28HTwfc8c=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=M6Q9vAbf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1787857390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xhUMft8JC1hXhIqq93oHYKOdEmHvveMSg/nGtCULBVE=;
	b=M6Q9vAbfPaNd3JjanQzLxxVZnbAP27gW8pfqSmasUIW7NO/zQnkq3AXb6lh7jc/zuqgEid
	Uo/ye2tZ/P0/Gstwr3R11AIvOwVBwv4sgP35pk9mK0cH6NETGZEU8YRVwL1z2jQVcP40dW
	6jOAJGs6j2RaZjS47eVCtqQNoVqFY0o=
From: Anthony Iliopoulos <ailiop@suse.com>
To: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>
Cc: netfs@lists.linux.dev
Subject: [PATCH] netfs: remove unused netfs_is_cache_enabled function
Date: Thu, 27 Aug 2026 21:03:00 +0200
Message-ID: <20260827190300.111434-1-ailiop@suse.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++++++++++++
X-Rspamd-Queue-Id: 2B77C21B90
X-Rspamd-Action: add header
X-Spam-Flag: YES
X-Spam-Score: 16.13
X-Spam-Level: ****************
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [16.13 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	BAYES_HAM(-3.00)[100.00%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	NEURAL_SPAM_SHORT(2.44)[0.812];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	MID_CONTAINS_FROM(1.00)[];
	HFILTER_HELO_IP_A(1.00)[kunlun.suse.cz];
	R_MISSING_CHARSET(0.50)[];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[kunlun.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DIRECT_TO_MX(0.00)[git-send-email 2.55.0];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kunlun.suse.cz:helo,suse.com:dkim,suse.com:email,suse.com:mid];
	DKIM_TRACE(0.00)[suse.com:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b306:2000::2:from]
X-Spam: Yes

The last call to the function was removed in commit dbd6f56d975b
("netfs: Fix netfs_create_write_req() to handle async cache object
 creation").

Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 fs/netfs/internal.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 420ee7b26580..340a5777ef96 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -228,18 +228,6 @@ void netfs_retry_writes(struct netfs_io_request *wreq);
 /*
  * Miscellaneous functions.
  */
-static inline bool netfs_is_cache_enabled(struct netfs_inode *ctx)
-{
-#if IS_ENABLED(CONFIG_FSCACHE)
-	struct fscache_cookie *cookie = ctx->cache;
-
-	return fscache_cookie_valid(cookie) && cookie->cache_priv &&
-		fscache_cookie_enabled(cookie);
-#else
-	return false;
-#endif
-}
-
 static inline bool netfs_is_cache_maybe_enabled(struct netfs_inode *ctx)
 {
 #if IS_ENABLED(CONFIG_FSCACHE)
-- 
2.55.0

