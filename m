Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69E44779F
	for <netfs@lists.linux.dev>; Fri,  2 Feb 2024 14:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706882624; cv=none; b=W7+UBWLR8KGjV+foFSp9UBfrOfRMh1zUMgrWc9iSlOhLxoIQZ75OZ94Aa8xk35NiCGTyoQJstsqO5xXtEMrE2PhqyGAp/ftxPO/7oCuhFvNDWEEHxK/tCuCoJT+5RvcBa8zcVCiF8WiXBAAJ2te5N5L0YnrdNGhHxIr6nz/PSiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706882624; c=relaxed/simple;
	bh=BJQfplmaSyBDDhVs/RstyS/GWbcJ/Hf09yPAoLpwVRQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=QOFeaAM6eGCmN/x5RvygVr7epbAfOXEQTaVY7k5zw8GQLtIzIgy6bnQnm4MgTuB9huHg5z99vvyoAhY55Wgu8uRh7gtlT3xxvOle0t2Kqb2GWRosuuY3IvjO6ZNJs8yYylaAmxY8e9dtxZFynkcUdizmAY9UpYSP3DxrMgMmDbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Ul8PGbrB; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Ul8PGbrB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1706882604; bh=utGP6OZSBLpmJu+9Td/7txs00XIiQw4x9gVWwrER68U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ul8PGbrBt4kxtka1rYm7pmMCzyeTUOVMV2bI48+Enws+A7SuNn/yKZZ3c6C1lzEmK
	 fQ24VcB3yfVSoOXixi6NXY5XoKGubwZoX0jkrc4cw2tnRP8sdKgtS/8FrKVK+ZM2tE
	 nbQdiT7D4mTSXoyzSDgC68DLCZjbQKwD+D70WSG4=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id D329E61; Fri, 02 Feb 2024 22:03:19 +0800
X-QQ-mid: xmsmtpt1706882599tcbkviljv
Message-ID: <tencent_2975FB767367603CED3622962437524A8C09@qq.com>
X-QQ-XMAILINFO: NyTsQ4JOu2J2VwOlPHaW7j2tsaSYtv5nx4xX96Q8K3YFvj37RAaq+YBf17GGzv
	 ArWxQSrW//mfyCBLhKljL6oRifpo4iGAx8GJ/Bea5/efYq0zN4jXPfZsSyxeFzr7xqc98q7KOh2E
	 JfG6AWuktRJq8mIlhX6jVhtE3VuMLnq8FEAKm7q+65dvDwLAQVoRh1xAq52WRbgJFFoQ/32YlcD6
	 eJGFtNUJ7B4WMD2ESJSn9ifhCHkuB22E5pm2jmS19XBqcDyq9ZGK4hZ1W8xhdwWabgYXcvwR0qSZ
	 W57mVLGvJ5/ub9VBlvex/ONfMZ53lJl/w0NdRaur+SERaZ5J3P7MSKu73wqh0UCECZJnPf8vgfUD
	 LnGg+VnpYeZyIXsGjrDjbfwouY+A5p/Fh8g7UK3szkmFdwKiAYLo2waBt6ALnY/WwFevedbzPIUX
	 z8EHR+ADf3DrbkmXf6H51uoiu0z2mH4CA+/SjVpLQGsDqmR1OfATo0WfX70lyo4YluhwXpFUeTry
	 40uq6W8XD0vzTw2JnFiTKEn9Bna/CL2GpqMHL5HKZWFMX9tjXKUq7RHhU+2LNs73HOTCK6s6Mcut
	 3BhElnjH9JPhFPOMKJN3YxHkD/fAbyAB3JMg6XE8+N7i6iHxw+ei6MpsoW51Ct+8PD+dVeH6efdU
	 NmJtJb+UxiQMPyCcnAcNPCN7v8rFwZ8YPGmTbTwCU+bpA/SM2qdw+Qpryif0X2IcIDs54Vhlhwr+
	 F3f1i+0LqiAzzVV8t5K3f8tiMvrG5VqdREWgwzI/7mxQZ8sHTHxgkWOEaRTIgfrNA8wgR9I0CPWj
	 Shi2zr51gKhzx8E2Gaw2IMoLSEmEzuzX+LtAePqOQAI7Gur5m0V1QVIuYztVnNEPBB3F07XUOuBP
	 DLA7Bs2cTpxPFOlOpur+IfFcTsqOPQ94sNawXvT70qIIuuV+0igsmTTlupsGk1j0xs+lFnWr4i
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+a4c1a7875b2babd9e359@syzkaller.appspotmail.com
Cc: dhowells@redhat.com,
	jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH next] fs/9p: fix uaf in in __fscache_relinquish_cookie
Date: Fri,  2 Feb 2024 22:03:19 +0800
X-OQ-MSGID: <20240202140318.4147829-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000007e7a63061062fcd9@google.com>
References: <0000000000007e7a63061062fcd9@google.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In v9fs_fid_get_dotl(), if p9_client_getattr_dotl() or v9fs_init_inode() fails,
the cookie will not be properly initialized and will result in accessing improperly
allocated cookies.

When the cookie is not initialized, exit the subsequent cookie recycling process
to avoid this issue.

Reported-and-tested-by: syzbot+a4c1a7875b2babd9e359@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/9p/vfs_inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 360a5304ec03..d27b7ecf7163 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -353,7 +353,8 @@ void v9fs_evict_inode(struct inode *inode)
 	filemap_fdatawrite(&inode->i_data);
 
 #ifdef CONFIG_9P_FSCACHE
-	fscache_relinquish_cookie(v9fs_inode_cookie(v9inode), false);
+	if (mapping_release_always(inode->i_mapping))
+		fscache_relinquish_cookie(v9fs_inode_cookie(v9inode), false);
 #endif
 }
 
-- 
2.43.0

