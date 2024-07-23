Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A55614F9E9;
	Tue, 23 Jul 2024 11:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721733852; cv=none; b=HL7Aok6OJ9093YczRnPgSts064/iOg4FqKwq/y3GJQHaPSBSC/zhiOYrxytRtb7Y/1ZHNhBq2dXaPCPCatBLpmqQB67RpiDqLD0yRAlMTySc985g4x6wKqPTln9TLEXWWfUKuFgewRZKrhn0jrnCYet22bAQh71eyZBp/97GQMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721733852; c=relaxed/simple;
	bh=WT1R4JXlAscYM9Eu3wRc2IO4UpVlARwdXG7i/HkXkj0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uBNS4d+i+8mQ34bFCdSx6EhhXAk5DXMUwx6MDtzERAaHKMHnte/CMfeJ0U/MX/BiPwpo8sjqi8WRENiHo0XlncHZki3Tp79VD8WnT12iDwW4g24sKDE45BDlE4IqtKoM9LHn0c0rldnZMT53kJGzTbrzWkMmvDRHXJQTK5Zt45A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ODQ99rdO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ODQ99rdO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48327C4AF09;
	Tue, 23 Jul 2024 11:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721733851;
	bh=WT1R4JXlAscYM9Eu3wRc2IO4UpVlARwdXG7i/HkXkj0=;
	h=Subject:To:Cc:From:Date:From;
	b=ODQ99rdOBV2iMXiylfwqVQ2ghPr0QXlAb4TrKxjkuJRO+SYfF0rL/VtwZRjHaidRU
	 RBlrvHx1B6Nbzp1OfvyZIPcSR/9sn/yZzB6LVpU6KOQUCpim4Ug0js4avlR2upNN1F
	 Ihh/q7I8uk4g5+a2aooMvvg/L9ww71f4ha+VyzJY=
Subject: Patch "cifs: Fix server re-repick on subrequest retry" has been added to the 6.10-stable tree
To: aaptel@suse.com,dhowells@redhat.com,gregkh@linuxfoundation.org,jlayton@kernel.org,netfs@lists.linux.dev,pc@manguebit.com,smfrench@gmail.com,stfrench@microsoft.com,tom@talpey.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 23 Jul 2024 13:23:54 +0200
Message-ID: <2024072354-drained-vision-44ea@gregkh>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore


This is a note to let you know that I've just added the patch titled

    cifs: Fix server re-repick on subrequest retry

to the 6.10-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     cifs-fix-server-re-repick-on-subrequest-retry.patch
and it can be found in the queue-6.10 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From de40579b903883274fe203865f29d66b168b7236 Mon Sep 17 00:00:00 2001
From: David Howells <dhowells@redhat.com>
Date: Thu, 18 Jul 2024 20:19:32 +0100
Subject: cifs: Fix server re-repick on subrequest retry

From: David Howells <dhowells@redhat.com>

commit de40579b903883274fe203865f29d66b168b7236 upstream.

When a subrequest is marked for needing retry, netfs will call
cifs_prepare_write() which will make cifs repick the server for the op
before renegotiating credits; it then calls cifs_issue_write() which
invokes smb2_async_writev() - which re-repicks the server.

If a different server is then selected, this causes the increment of
server->in_flight to happen against one record and the decrement to happen
against another, leading to misaccounting.

Fix this by just removing the repick code in smb2_async_writev().  As this
is only called from netfslib-driven code, cifs_prepare_write() should
always have been called first, and so server should never be NULL and the
preparatory step is repeated in the event that we do a retry.

The problem manifests as a warning looking something like:

 WARNING: CPU: 4 PID: 72896 at fs/smb/client/smb2ops.c:97 smb2_add_credits+0x3f0/0x9e0 [cifs]
 ...
 RIP: 0010:smb2_add_credits+0x3f0/0x9e0 [cifs]
 ...
  smb2_writev_callback+0x334/0x560 [cifs]
  cifs_demultiplex_thread+0x77a/0x11b0 [cifs]
  kthread+0x187/0x1d0
  ret_from_fork+0x34/0x60
  ret_from_fork_asm+0x1a/0x30

Which may be triggered by a number of different xfstests running against an
Azure server in multichannel mode.  generic/249 seems the most repeatable,
but generic/215, generic/249 and generic/308 may also show it.

Fixes: 3ee1a1fc3981 ("cifs: Cut over to using netfslib")
Cc: stable@vger.kernel.org
Reported-by: Steve French <smfrench@gmail.com>
Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
Acked-by: Tom Talpey <tom@talpey.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Aurelien Aptel <aaptel@suse.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/smb2pdu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 2ae2dbb6202b..bb84a89e5905 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4859,9 +4859,6 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 	struct cifs_io_parms *io_parms = NULL;
 	int credit_request;
 
-	if (!wdata->server || test_bit(NETFS_SREQ_RETRYING, &wdata->subreq.flags))
-		server = wdata->server = cifs_pick_channel(tcon->ses);
-
 	/*
 	 * in future we may get cifs_io_parms passed in from the caller,
 	 * but for now we construct it here...
-- 
2.45.2



Patches currently in stable-queue which might be from dhowells@redhat.com are

queue-6.10/cifs-fix-server-re-repick-on-subrequest-retry.patch
queue-6.10/cifs-fix-setting-of-zero_point-after-dio-write.patch
queue-6.10/cifs-fix-missing-error-code-set.patch
queue-6.10/cifs-fix-missing-fscache-invalidation.patch
