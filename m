Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBBA14A0BF;
	Tue, 23 Jul 2024 11:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721733846; cv=none; b=At3A73SWaUHLWUp4YVThp2AcHG14EkmsjIeoz/lBWbSckZOPtdR5mDmkD8UTH24CokcF8Y6/kYZ7amMWT8sY3TYTlj1WXWG/8rRZXYug0hf1TW8ipO8Ty3nciygI9U8/9qJ/2GlebX2mUFnEueRaZUfgiNUgsNRmKyeuH6Iltwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721733846; c=relaxed/simple;
	bh=Klw486uuNcle1qDAfXyiJwePzo/sZszGVJP6osqHnAo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AgVyzuRDMLwD/KyqCnZgBC+ugFe0W5Kkjuw9XXalY/V6RpgkdQpRk2hIIz4iEOfZV3invqK/f9uv7dH6K7mEVUNxDOcH2zqOtiSDI6cUWB5xk8GFle1881dRVp4MVrIsnOYATGK4W3186+vpTuyP4c3KWkV2jmisvr8uIGI8/x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nprMIQll; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nprMIQll"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53AD3C4AF0A;
	Tue, 23 Jul 2024 11:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721733845;
	bh=Klw486uuNcle1qDAfXyiJwePzo/sZszGVJP6osqHnAo=;
	h=Subject:To:Cc:From:Date:From;
	b=nprMIQlln39CxvE5zSNSdWejncZDuLso6vCuJoQKMkAOnLLbQKUt+JcBBIhc3Mdsa
	 9aTDpfarNm4DHAscZBDkeRQHqYpTk4k+ks8qFlU50jlCHUbiHL6jLwu/pbG0PonWFp
	 QLdILNLDdvX5X4lAdVPa3qNx7omCjUZpXbCKJlcU=
Subject: Patch "cifs: Fix missing fscache invalidation" has been added to the 6.10-stable tree
To: dhowells@redhat.com,gregkh@linuxfoundation.org,jlayton@kernel.org,netfs@lists.linux.dev,pc@manguebit.com,stfrench@microsoft.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 23 Jul 2024 13:23:54 +0200
Message-ID: <2024072354-outhouse-chowtime-0629@gregkh>
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

    cifs: Fix missing fscache invalidation

to the 6.10-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     cifs-fix-missing-fscache-invalidation.patch
and it can be found in the queue-6.10 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From a07d38afd15281c42613943a9a715c3ba07c21e6 Mon Sep 17 00:00:00 2001
From: David Howells <dhowells@redhat.com>
Date: Fri, 19 Jul 2024 16:01:48 +0100
Subject: cifs: Fix missing fscache invalidation

From: David Howells <dhowells@redhat.com>

commit a07d38afd15281c42613943a9a715c3ba07c21e6 upstream.

A network filesystem needs to implement a netfslib hook to invalidate
fscache if it's to be able to use the cache.

Fix cifs to implement the cache invalidation hook.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Cc: stable@vger.kernel.org
Fixes: 3ee1a1fc3981 ("cifs: Cut over to using netfslib")
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/file.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -123,6 +123,11 @@ fail:
 	goto out;
 }
 
+static void cifs_netfs_invalidate_cache(struct netfs_io_request *wreq)
+{
+	cifs_invalidate_cache(wreq->inode, 0);
+}
+
 /*
  * Split the read up according to how many credits we can get for each piece.
  * It's okay to sleep here if we need to wait for more credit to become
@@ -307,6 +312,7 @@ const struct netfs_request_ops cifs_req_
 	.begin_writeback	= cifs_begin_writeback,
 	.prepare_write		= cifs_prepare_write,
 	.issue_write		= cifs_issue_write,
+	.invalidate_cache	= cifs_netfs_invalidate_cache,
 };
 
 /*


Patches currently in stable-queue which might be from dhowells@redhat.com are

queue-6.10/cifs-fix-server-re-repick-on-subrequest-retry.patch
queue-6.10/cifs-fix-setting-of-zero_point-after-dio-write.patch
queue-6.10/cifs-fix-missing-error-code-set.patch
queue-6.10/cifs-fix-missing-fscache-invalidation.patch
