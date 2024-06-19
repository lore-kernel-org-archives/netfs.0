Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5C013E883;
	Wed, 19 Jun 2024 11:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718797303; cv=none; b=GrLdgIbBKeJPvOrwHyMcVvkaoApZYlNudd5fEjn2XN8frQ3MLHMOvdf/pjyx3egp6HipMYTmGVlVCF/ibtYvwJX++7n9miCX21uQD3NPEwZIX0KSvUJ4C6TRX+Ymx3Sm01JvIjPE+E1kzLr1KxA7s6t7ecSgXXeS7RfVa+hSKMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718797303; c=relaxed/simple;
	bh=aETZJ6QFcxWCmeFR+2UkzJ4h4YY19n/zh9NWSvVXkk4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iSA1Lm6F1Ysi97BGCckey9wvaITKUxVPVvajjjYyp/TOgJCvUGZEIH86kaUyEpSsHwBbc+zLCiPJLbmYYISn+I7KB6DeJAcW+hKieDMLYlz90Y2SfqorXg7EB5+iHMa42ims7IayBy/SYLUa4wEYXxZ3jY58O1bsQvSjFs9Fnbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oJEK0SC2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oJEK0SC2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223B6C2BBFC;
	Wed, 19 Jun 2024 11:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718797302;
	bh=aETZJ6QFcxWCmeFR+2UkzJ4h4YY19n/zh9NWSvVXkk4=;
	h=Subject:To:Cc:From:Date:From;
	b=oJEK0SC27Esx4fkprBwSTtsEuoYR8IousQi1erSqsL2D0sw8YhesWngQA5XIEfzr2
	 o93CnKxCYpY6qWpdQZyWAC7az+6L4XwrRmzcAAY34oOEvYbkRSEvd1QFIb5QJW8GSI
	 KqyJ7HzQGvxAKh6/1rknIq/P0uhXhn58ZRjj/BDo=
Subject: Patch "cachefiles, erofs: Fix NULL deref in when cachefiles is not doing ondemand-mode" has been added to the 6.1-stable tree
To: chao@kernel.org,dhowells@redhat.com,gregkh@linuxfoundation.org,huyue2@coolpad.com,jefflexu@linux.alibaba.com,linux-erofs@lists.ozlabs.org,marc.dionne@auristor.com,netfs@lists.linux.dev,xiang@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Jun 2024 13:41:39 +0200
Message-ID: <2024061939-liability-failing-7856@gregkh>
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

    cachefiles, erofs: Fix NULL deref in when cachefiles is not doing ondemand-mode

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     cachefiles-erofs-fix-null-deref-in-when-cachefiles-is-not-doing-ondemand-mode.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From c3d6569a43322f371e7ba0ad386112723757ac8f Mon Sep 17 00:00:00 2001
From: David Howells <dhowells@redhat.com>
Date: Fri, 19 Jan 2024 20:49:34 +0000
Subject: cachefiles, erofs: Fix NULL deref in when cachefiles is not doing ondemand-mode

From: David Howells <dhowells@redhat.com>

commit c3d6569a43322f371e7ba0ad386112723757ac8f upstream.

cachefiles_ondemand_init_object() as called from cachefiles_open_file() and
cachefiles_create_tmpfile() does not check if object->ondemand is set
before dereferencing it, leading to an oops something like:

	RIP: 0010:cachefiles_ondemand_init_object+0x9/0x41
	...
	Call Trace:
	 <TASK>
	 cachefiles_open_file+0xc9/0x187
	 cachefiles_lookup_cookie+0x122/0x2be
	 fscache_cookie_state_machine+0xbe/0x32b
	 fscache_cookie_worker+0x1f/0x2d
	 process_one_work+0x136/0x208
	 process_scheduled_works+0x3a/0x41
	 worker_thread+0x1a2/0x1f6
	 kthread+0xca/0xd2
	 ret_from_fork+0x21/0x33

Fix this by making cachefiles_ondemand_init_object() return immediately if
cachefiles->ondemand is NULL.

Fixes: 3c5ecfe16e76 ("cachefiles: extract ondemand info field from cachefiles_object")
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Gao Xiang <xiang@kernel.org>
cc: Chao Yu <chao@kernel.org>
cc: Yue Hu <huyue2@coolpad.com>
cc: Jeffle Xu <jefflexu@linux.alibaba.com>
cc: linux-erofs@lists.ozlabs.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/cachefiles/ondemand.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -611,6 +611,9 @@ int cachefiles_ondemand_init_object(stru
 	struct fscache_volume *volume = object->volume->vcookie;
 	size_t volume_key_size, cookie_key_size, data_len;
 
+	if (!object->ondemand)
+		return 0;
+
 	/*
 	 * CacheFiles will firstly check the cache file under the root cache
 	 * directory. If the coherency check failed, it will fallback to


Patches currently in stable-queue which might be from dhowells@redhat.com are

queue-6.1/cachefiles-resend-an-open-request-if-the-read-reques.patch
queue-6.1/cachefiles-add-restore-command-to-recover-inflight-o.patch
queue-6.1/cachefiles-introduce-object-ondemand-state.patch
queue-6.1/cachefiles-extract-ondemand-info-field-from-cachefil.patch
queue-6.1/cachefiles-erofs-fix-null-deref-in-when-cachefiles-is-not-doing-ondemand-mode.patch
