Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F903D301A
	for <netfs@lists.linux.dev>; Fri, 14 Aug 2026 02:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786673808; cv=none; b=MnPcB+nBbxGL9MVhNxdk55mgWmyU+kodbs7waYSfMOFYUWHyVnmV7LX7//P+MvoD5ODlMtUH61sbiBbpsp/B15KyAC0b/zduiaJEj8kBIvPAPp37svqeQsy5CrIqRVfXquleolM/i1g73O4f7NofPz4TejKCqT3dUZJ4W3/jmlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786673808; c=relaxed/simple;
	bh=Zqayx5jWRDBmSgLQJL5o3IkAB+JCJdoSvtLCN4+biEw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=K7AwDqrLhAQIEPQyWLPWk14+OY+XatOrBvXlISecU7/rHj80Bw+sLc5gjH2sxiSFkeDNBXWAkTgEICFHcvLwLEtLznksnaCG5+qvnDnl5zpLp3vVGI+ZNvjnSC+Nr0JxED1gT1jFf6sWDnroc26XguH+6KegkjQhC+RhoN80azs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=t/Te/nWh; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="t/Te/nWh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1786673800; bh=xgVA9fMTk1lJSNhZ5dgHoKNUTDoGRT8Mpx79uIRVRDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=t/Te/nWhxjpeV82iWhxArPinH9o+iCF2Xz+jWzos9dXL168lcv3S00mZVKOSFxBp0
	 Y349aXpJ1gQGk3qBLm/0w1x4GbsNn8JEhZvLRNHnzSW0D9c4RXu8GGZEdV0JqiUArI
	 aml/Iw56NjHxNJrsPNnaOkhJ5O8FCnQ5EAdXbCdE=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 42599491; Fri, 14 Aug 2026 10:16:37 +0800
X-QQ-mid: xmsmtpt1786673797tuv62yyyf
Message-ID: <tencent_9ADD949953CFE50D8A25BD8DD092395DA507@qq.com>
X-QQ-XMAILINFO: NbgegmlEc3JuedYX19xl12GRt0D3yMUlriQbZyMB+1Os4MHkiDawvlRVkG8EqX
	 ZblfP2J8Woirfzmt0MeEPagf4Z3Rs4ZSLeSHG6BsoMkR4kgWDSS5uZ4ITCe1H4jtV7+WRIz99jca
	 IlrQDTtbdlz3rNffg1FTKd45OmrHQx9hQhKVMOhECoHeVVx+A6i3lTpyGIFNi/pa+Oh+DMaCTpE0
	 hJEa4eZNHDq6UY1bUUdl+FcMVHIJNkW0oBfP+vqtm8PwZ0WEVvj7gZC9GXgUjVU0HIbRDZVrAOLB
	 73OqbLrpc428KhFCps8Bf0nia9uHUePm8GPd6azCJEP24YyM51pj+wsl+8nH2bFMHapZNLLeedpR
	 Mmhl9/veEOtoWycEe04vtRUIgMBwf2AFa9ymS3KjoTYI+b37MlFT/Fn4Y/vZuuT/LtMWjNOfLqYB
	 GtGe9VtbOwiQ6ucSsicnMuCjwfLb+fzydDXjcUSsfV5b+zKbSdkLTQo3XcjT3HGbWCWpmcp2Dwro
	 A+h6f1uQBQwchPw3S0gt5I4ZOlH2S7s6dRQhwywn9DzlzoYepu6v2RdVzofmQSk/rFCUi93gGRn7
	 WOF2qUGXkejS4lXdd8TfND3urjpMXsK6gTMxZNMDhtFcSvQsQ2WK+kSwNhHex+3uHElC5PV/jwO2
	 sQLfs2emSMkjr3ghCqg+8SRX1yl2frAFdlnnLExjbHn45up5G30uber0BjN7eI6uiZOhIHuw3iQF
	 v/X4ZMAPYiHAx3W78im3Sn2rXdF/NWRNNb9fx3aMiUeYfI4yF0f1UCoEnkJSfhaP+XBUl0rdhKhB
	 uxFwU/op7gIO31DomXD0Sb4PSHYbyje2ZVsubxFXZ7K/DGnqPg6GdlRsI6P7XlYO6burOylTTIrF
	 JtzdL9FXjQoAaHyCCsieEC2xPHkdIiqpyuH7EM9ioSAlmSva2umuzngFZGMx3pnJulY4XVVK9pY0
	 qdLbZc7uz9MPzeB9WABukazbV3LmAEPhgms+OJ3Jf01K9AxVeQyOcg3JaP2FM4msMf+Dsio2/x96
	 aEHsfuX9+eQ9VrIXVC
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+6a13fc77eb6f0802be2d@syzkaller.appspotmail.com
Cc: dhowells@redhat.com,
	pc@manguebit.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] netfs: break unbuffered write when netfs_alloc_subrequest() fails
Date: Fri, 14 Aug 2026 10:16:38 +0800
X-OQ-MSGID: <20260814021637.202471-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6a7dd201.f70deec7.2acc03.0008.GAE@google.com>
References: <6a7dd201.f70deec7.2acc03.0008.GAE@google.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a null-ptr-deref below [1] following a fault injection in
netfs_alloc_subrequest(). [0]

When netfs_alloc_subrequest() fails, subreq is NULL.
Later, netfs_prepare_write() tries to initialize members of
subreq(e.g., source), the issue in [1] is triggered.

Let's handle the error of netfs_prepare_write() properly.

[0]
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
Call Trace:
 netfs_alloc_subrequest+0x116/0x3f0
 netfs_prepare_write+0x76/0x7b0
 netfs_unbuffered_write+0x75c/0x2020
 netfs_unbuffered_write_iter_locked+0x7d6/0xa80
 netfs_unbuffered_write_iter+0x442/0x720
 v9fs_file_write_iter+0xbf/0x100
 vfs_write+0x6ac/0x1050

[1]
KASAN: null-ptr-deref in range [0x00000000000000a8-0x00000000000000af]
RIP: 0010:netfs_prepare_write+0xbc/0x7b0 fs/netfs/write_issue.c:173
Call Trace:
 netfs_unbuffered_write+0x75c/0x2020 fs/netfs/direct_write.c:111
 netfs_unbuffered_write_iter_locked+0x7d6/0xa80 fs/netfs/direct_write.c:290
 netfs_unbuffered_write_iter+0x442/0x720 fs/netfs/direct_write.c:382
 v9fs_file_write_iter+0xbf/0x100 fs/9p/vfs_file.c:409
 new_sync_write fs/read_write.c:595 [inline]
 
Fixes: 288ace2f57c9 ("netfs: New writeback implementation")
Reported-by: syzbot+6a13fc77eb6f0802be2d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6a13fc77eb6f0802be2d
Tested-by: syzbot+6a13fc77eb6f0802be2d@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/netfs/direct_write.c | 4 ++++
 fs/netfs/write_issue.c  | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index c16fbad286a1..567b946b7a56 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -110,6 +110,10 @@ static int netfs_unbuffered_write(struct netfs_io_request *wreq)
 		if (!subreq) {
 			netfs_prepare_write(wreq, stream, wreq->start + wreq->transferred);
 			subreq = stream->construct;
+			if (!subreq) {
+				wreq->error = -ENOMEM;
+				break;
+			}
 			stream->construct = NULL;
 		}
 
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 2d9cfcd43658..851f6f93ad45 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -170,6 +170,8 @@ void netfs_prepare_write(struct netfs_io_request *wreq,
 		rolling_buffer_make_space(&wreq->buffer, wreq->gfp);
 
 	subreq = netfs_alloc_subrequest(wreq);
+	if (!subreq)
+		return;
 	subreq->source		= stream->source;
 	subreq->start		= start;
 	subreq->stream_nr	= stream->stream_nr;
-- 
2.43.0

