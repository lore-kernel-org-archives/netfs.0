Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75A1155C97
	for <netfs@lists.linux.dev>; Wed, 17 Sep 2025 13:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117558; cv=none; b=gcUNtn3xHqvxCI+SNMYEZuDQzMGImGz/+qOsdEcpJHUu6dI36IXWXlC7y17SIeaYKFHjQM7jREZ1jWP0Ry0VW9ft1D+vamSXzEgsCksgZZ52SACq99kMlxxRdMtAB2qBM3OvD2/wBdJRZld5IAdLz+TO7o6/pfVE4Nz07I/wENQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117558; c=relaxed/simple;
	bh=PrUJJzVFvmm36DIJti8SrUXxJCazBDH+YYCteM1Y73o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nd8jZJAqK1sk0vd3UJdN+2vR6yA7FIbbeJhB1Qs4eE9Ydbv85aD3lLEt7jjHubg+is77OHeYsgk2USqF6wo9yfSSnv/2cW6dtB0r4Ly7SpV56VXBrtlUodseYJqqwHlgvdHFdpqIGVPX6oY8Jp8xBUZEVGGD2gh+jDogk22OxOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=iD/iEmtB; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="iD/iEmtB"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ea115556b2so2369997f8f.2
        for <netfs@lists.linux.dev>; Wed, 17 Sep 2025 06:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1758117554; x=1758722354; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lap5MP7nlD48/VF2N7tzbvJAvOx9W0MLfvRLvQ1QRh0=;
        b=iD/iEmtBU5Euk5matQUFtPj4r+VbX3+S5NyjYpJQADUCxSF+SYmUBAim0FVoFfOFA5
         fQGR7v6XkPWC8IuGyqgbLET4SHSWnVlp5YqdcFmWiLDnGouSGzkYTK+XnE1CrQBip/0k
         Nqg3gORvsqPuY0WfrJ0z4Cfv4CN+nTYNN/Sks/iTOUzj889hK4VIul5kYc3GVR/+uCXP
         A5/PazoqzAagiW0c4oziEAcewbQUVYWOsM/66XWNExW5o8KvlRiSuaG+1jJ03bvj+FiB
         BkMXxEMgi7b5dAkB2hwyiyiTMlLJEWbFo/6RU6IZbr8T+oXShJldnJyMxRy6TOHGB+TA
         D06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758117554; x=1758722354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lap5MP7nlD48/VF2N7tzbvJAvOx9W0MLfvRLvQ1QRh0=;
        b=EalQzP+jiQ7YIe9+48d6/57/amIIrC7mSN98mg+UqToQQril3wHck4F9o53kR6A3hI
         GIIzJSta2Ckg/YLdCSA7mz4GAJj6b3f5lJmEJofQcFKy79nnZjgqyNlGUJkMWAP8Espq
         lZ0o28ArWRrbJGO3AiuZVxpIiJSa+uXcDRZ16CEYVLd/60g0DhiB98exPNk+fssvC//n
         Bi4vXlof6OpV8QXVOZ5+IDN/lkqh2jEIE2NMUoGalkudkDdk5V6AUI49mlqXd/RKL4xw
         tqTwYIs+vLPJqvBC6p4iRLhKzBeidGwW4LCw6/pjR9Gb2FEC/3YtVTQ2v8pS6l91xI1J
         x25w==
X-Forwarded-Encrypted: i=1; AJvYcCVJoQtJyLnPE3dSP1QK8EvEX7OnvheobsAXgoh4DsvaFoN3xFq/LmZ1AIIRkuVaaeLlU89TZQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxJ+k4n1eHkfPvKRXWh6hF8kXDgbQ/mtPwylNSwPCBZ0Y7wevLi
	+rIONvjtdIF8Z+5PMHKmnx+tRlYZt0NxaIVmoYzEkRGeYCHlWxa4eB1mrM25HRPNQeQ=
X-Gm-Gg: ASbGncuPE7hndlZFT/o7+LgBi0gppHIhn5ZaaU45muxXe8GEyZy0iZu6lbM4H4sYYZl
	42gCEEzztMMod9V10CWd2aw2jiSsRbwmSAdHyLlIsyk6fCpYvscEUDLbMwTq1bNHUIKwj4vfF1/
	63EcNIy0JyM8CASpSoaDyfmWEBEcw0DQlsQtsshcy1uXgrOyDAsz6BMqX1wMT919uQFzQjAmU2c
	2hy6LSic9UiVs9TvbmkMB/JvkmiNOwPx5NvJTogfi4s1juDfoiAQnBEsmX33cFKIF1lbfJDTHq5
	KxrP0Pg5gZYJw4gGlNddgGDVN7/P0DbM6JwokzxmJKDTqDQ7gCX11jrJjmQauY4JwCqugr1tSei
	/ClCiIwpmhSBr5FGQyXs5XXD2T5cymBvUY2z5uYegMWIMpIz3pEOOfkZL67nahN8w/Q28Jixae/
	L6bij8eQwCynRzR5yicyrlI58=
X-Google-Smtp-Source: AGHT+IG4B+42kk7nm7hZBVS+z4VnAr/ThqAaSrNOgMeO7+VX6UW6speHZp5k+bSQDJWnjtPMeDCxOg==
X-Received: by 2002:a05:6000:43c7:20b0:3e9:2189:c2ca with SMTP id ffacd0b85a97d-3ecdfa52b5cmr1761915f8f.39.1758117553938;
        Wed, 17 Sep 2025 06:59:13 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f055a00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f05:5a00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e9a591a41csm15740901f8f.7.2025.09.17.06.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 06:59:13 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: slava.dubeyko@ibm.com,
	xiubli@redhat.com,
	idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Max Kellermann <max.kellermann@ionos.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] ceph: fix deadlock bugs by making iput() calls asynchronous
Date: Wed, 17 Sep 2025 15:59:07 +0200
Message-ID: <20250917135907.2218073-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The iput() function is a dangerous one - if the reference counter goes
to zero, the function may block for a long time due to:

- inode_wait_for_writeback() waits until writeback on this inode
  completes

- the filesystem-specific "evict_inode" callback can do similar
  things; e.g. all netfs-based filesystems will call
  netfs_wait_for_outstanding_io() which is similar to
  inode_wait_for_writeback()

Therefore, callers must carefully evaluate the context they're in and
check whether invoking iput() is a good idea at all.

Most of the time, this is not a problem because the dcache holds
references to all inodes, and the dcache is usually the one to release
the last reference.  But this assumption is fragile.  For example,
under (memcg) memory pressure, the dcache shrinker is more likely to
release inode references, moving the inode eviction to contexts where
that was extremely unlikely to occur.

Our production servers "found" at least two deadlock bugs in the Ceph
filesystem that were caused by this iput() behavior:

1. Writeback may lead to iput() calls in Ceph (e.g. from
   ceph_put_wrbuffer_cap_refs()) which deadlocks in
   inode_wait_for_writeback().  Waiting for writeback completion from
   within writeback will obviously never be able to make any progress.
   This leads to blocked kworkers like this:

    INFO: task kworker/u777:6:1270802 blocked for more than 122 seconds.
          Not tainted 6.16.7-i1-es #773
    task:kworker/u777:6  state:D stack:0 pid:1270802 tgid:1270802 ppid:2
          task_flags:0x4208060 flags:0x00004000
    Workqueue: writeback wb_workfn (flush-ceph-3)
    Call Trace:
     <TASK>
     __schedule+0x4ea/0x17d0
     schedule+0x1c/0xc0
     inode_wait_for_writeback+0x71/0xb0
     evict+0xcf/0x200
     ceph_put_wrbuffer_cap_refs+0xdd/0x220
     ceph_invalidate_folio+0x97/0xc0
     ceph_writepages_start+0x127b/0x14d0
     do_writepages+0xba/0x150
     __writeback_single_inode+0x34/0x290
     writeback_sb_inodes+0x203/0x470
     __writeback_inodes_wb+0x4c/0xe0
     wb_writeback+0x189/0x2b0
     wb_workfn+0x30b/0x3d0
     process_one_work+0x143/0x2b0
     worker_thread+0x30a/0x450

2. In the Ceph messenger thread (net/ceph/messenger*.c), any iput()
   call may invoke ceph_evict_inode() which will deadlock in
   netfs_wait_for_outstanding_io(); since this blocks the messenger
   thread, completions from the Ceph servers will not ever be received
   and handled.

It looks like these deadlock bugs have been in the Ceph filesystem
code since forever (therefore no "Fixes" tag in this patch).  There
may be various ways to solve this:

- make iput() asynchronous and defer the actual eviction like fput()
  (may add overhead)

- make iput() only asynchronous if I_SYNC is set (doesn't solve random
  things happening inside the "evict_inode" callback)

- add iput_deferred() to make this asynchronous behavior/overhead
  optional and explicit

- refactor Ceph to avoid iput() calls from within writeback and
  messenger (if that is even possible)

- add a Ceph-specific workaround

After advice from Mateusz Guzik, I decided to do the latter.  The
implementation is simple because it piggybacks on the existing
work_struct for ceph_queue_inode_work() - ceph_inode_work() calls
iput() at the end which means we can donate the last reference to it.

This patch adds ceph_iput_async() and converts lots of iput() calls to
it - at least those that may come through writeback and the messenger.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>
Cc: stable@vger.kernel.org
---

v1->v2: using atomic_add_unless() instead of atomic_add_unless() to
  avoid letting i_count drop to zero which may cause races (thanks
  Mateusz Guzik)

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/addr.c       |  2 +-
 fs/ceph/caps.c       | 16 ++++++++--------
 fs/ceph/dir.c        |  2 +-
 fs/ceph/inode.c      | 34 ++++++++++++++++++++++++++++++++++
 fs/ceph/mds_client.c | 30 +++++++++++++++---------------
 fs/ceph/quota.c      |  4 ++--
 fs/ceph/snap.c       | 10 +++++-----
 fs/ceph/super.h      |  2 ++
 8 files changed, 68 insertions(+), 32 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 322ed268f14a..fc497c91530e 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -265,7 +265,7 @@ static void finish_netfs_read(struct ceph_osd_request *req)
 	subreq->error = err;
 	trace_netfs_sreq(subreq, netfs_sreq_trace_io_progress);
 	netfs_read_subreq_terminated(subreq);
-	iput(req->r_inode);
+	ceph_iput_async(req->r_inode);
 	ceph_dec_osd_stopping_blocker(fsc->mdsc);
 }
 
diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index b1a8ff612c41..af9e3ae9ab7e 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1771,7 +1771,7 @@ void ceph_flush_snaps(struct ceph_inode_info *ci,
 	spin_unlock(&mdsc->snap_flush_lock);
 
 	if (need_put)
-		iput(inode);
+		ceph_iput_async(inode);
 }
 
 /*
@@ -3319,7 +3319,7 @@ static void __ceph_put_cap_refs(struct ceph_inode_info *ci, int had,
 	if (wake)
 		wake_up_all(&ci->i_cap_wq);
 	while (put-- > 0)
-		iput(inode);
+		ceph_iput_async(inode);
 }
 
 void ceph_put_cap_refs(struct ceph_inode_info *ci, int had)
@@ -3419,7 +3419,7 @@ void ceph_put_wrbuffer_cap_refs(struct ceph_inode_info *ci, int nr,
 	if (complete_capsnap)
 		wake_up_all(&ci->i_cap_wq);
 	while (put-- > 0) {
-		iput(inode);
+		ceph_iput_async(inode);
 	}
 }
 
@@ -3917,7 +3917,7 @@ static void handle_cap_flush_ack(struct inode *inode, u64 flush_tid,
 	if (wake_mdsc)
 		wake_up_all(&mdsc->cap_flushing_wq);
 	if (drop)
-		iput(inode);
+		ceph_iput_async(inode);
 }
 
 void __ceph_remove_capsnap(struct inode *inode, struct ceph_cap_snap *capsnap,
@@ -4008,7 +4008,7 @@ static void handle_cap_flushsnap_ack(struct inode *inode, u64 flush_tid,
 			wake_up_all(&ci->i_cap_wq);
 		if (wake_mdsc)
 			wake_up_all(&mdsc->cap_flushing_wq);
-		iput(inode);
+		ceph_iput_async(inode);
 	}
 }
 
@@ -4557,7 +4557,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 done:
 	mutex_unlock(&session->s_mutex);
 done_unlocked:
-	iput(inode);
+	ceph_iput_async(inode);
 out:
 	ceph_dec_mds_stopping_blocker(mdsc);
 
@@ -4636,7 +4636,7 @@ unsigned long ceph_check_delayed_caps(struct ceph_mds_client *mdsc)
 			doutc(cl, "on %p %llx.%llx\n", inode,
 			      ceph_vinop(inode));
 			ceph_check_caps(ci, 0);
-			iput(inode);
+			ceph_iput_async(inode);
 			spin_lock(&mdsc->cap_delay_lock);
 		}
 
@@ -4675,7 +4675,7 @@ static void flush_dirty_session_caps(struct ceph_mds_session *s)
 		spin_unlock(&mdsc->cap_dirty_lock);
 		ceph_wait_on_async_create(inode);
 		ceph_check_caps(ci, CHECK_CAPS_FLUSH);
-		iput(inode);
+		ceph_iput_async(inode);
 		spin_lock(&mdsc->cap_dirty_lock);
 	}
 	spin_unlock(&mdsc->cap_dirty_lock);
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 32973c62c1a2..ec73ed52a227 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1290,7 +1290,7 @@ static void ceph_async_unlink_cb(struct ceph_mds_client *mdsc,
 		ceph_mdsc_free_path_info(&path_info);
 	}
 out:
-	iput(req->r_old_inode);
+	ceph_iput_async(req->r_old_inode);
 	ceph_mdsc_release_dir_caps(req);
 }
 
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index f67025465de0..d7c0ed82bf62 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2191,6 +2191,40 @@ void ceph_queue_inode_work(struct inode *inode, int work_bit)
 	}
 }
 
+/**
+ * Queue an asynchronous iput() call in a worker thread.  Use this
+ * instead of iput() in contexts where evicting the inode is unsafe.
+ * For example, inode eviction may cause deadlocks in
+ * inode_wait_for_writeback() (when called from within writeback) or
+ * in netfs_wait_for_outstanding_io() (when called from within the
+ * Ceph messenger).
+ */
+void ceph_iput_async(struct inode *inode)
+{
+	if (unlikely(!inode))
+		return;
+
+	if (likely(atomic_add_unless(&inode->i_count, -1, 1)))
+		/* somebody else is holding another reference -
+		 * nothing left to do for us
+		 */
+		return;
+
+	doutc(ceph_inode_to_fs_client(inode)->client, "%p %llx.%llx\n", inode, ceph_vinop(inode));
+
+	/* simply queue a ceph_inode_work() (donating the remaining
+	 * reference) without setting i_work_mask bit; other than
+	 * putting the reference, there is nothing to do
+	 */
+	WARN_ON_ONCE(!queue_work(ceph_inode_to_fs_client(inode)->inode_wq,
+				 &ceph_inode(inode)->i_work));
+
+	/* note: queue_work() cannot fail; it i_work were already
+	 * queued, then it would be holding another reference, but no
+	 * such reference exists
+	 */
+}
+
 static void ceph_do_invalidate_pages(struct inode *inode)
 {
 	struct ceph_client *cl = ceph_inode_to_client(inode);
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 3bc72b47fe4d..22d75c3be5a8 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1097,14 +1097,14 @@ void ceph_mdsc_release_request(struct kref *kref)
 		ceph_msg_put(req->r_reply);
 	if (req->r_inode) {
 		ceph_put_cap_refs(ceph_inode(req->r_inode), CEPH_CAP_PIN);
-		iput(req->r_inode);
+		ceph_iput_async(req->r_inode);
 	}
 	if (req->r_parent) {
 		ceph_put_cap_refs(ceph_inode(req->r_parent), CEPH_CAP_PIN);
-		iput(req->r_parent);
+		ceph_iput_async(req->r_parent);
 	}
-	iput(req->r_target_inode);
-	iput(req->r_new_inode);
+	ceph_iput_async(req->r_target_inode);
+	ceph_iput_async(req->r_new_inode);
 	if (req->r_dentry)
 		dput(req->r_dentry);
 	if (req->r_old_dentry)
@@ -1118,7 +1118,7 @@ void ceph_mdsc_release_request(struct kref *kref)
 		 */
 		ceph_put_cap_refs(ceph_inode(req->r_old_dentry_dir),
 				  CEPH_CAP_PIN);
-		iput(req->r_old_dentry_dir);
+		ceph_iput_async(req->r_old_dentry_dir);
 	}
 	kfree(req->r_path1);
 	kfree(req->r_path2);
@@ -1240,7 +1240,7 @@ static void __unregister_request(struct ceph_mds_client *mdsc,
 	}
 
 	if (req->r_unsafe_dir) {
-		iput(req->r_unsafe_dir);
+		ceph_iput_async(req->r_unsafe_dir);
 		req->r_unsafe_dir = NULL;
 	}
 
@@ -1413,7 +1413,7 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
 		cap = rb_entry(rb_first(&ci->i_caps), struct ceph_cap, ci_node);
 	if (!cap) {
 		spin_unlock(&ci->i_ceph_lock);
-		iput(inode);
+		ceph_iput_async(inode);
 		goto random;
 	}
 	mds = cap->session->s_mds;
@@ -1422,7 +1422,7 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
 	      cap == ci->i_auth_cap ? "auth " : "", cap);
 	spin_unlock(&ci->i_ceph_lock);
 out:
-	iput(inode);
+	ceph_iput_async(inode);
 	return mds;
 
 random:
@@ -1841,7 +1841,7 @@ int ceph_iterate_session_caps(struct ceph_mds_session *session,
 		spin_unlock(&session->s_cap_lock);
 
 		if (last_inode) {
-			iput(last_inode);
+			ceph_iput_async(last_inode);
 			last_inode = NULL;
 		}
 		if (old_cap) {
@@ -1874,7 +1874,7 @@ int ceph_iterate_session_caps(struct ceph_mds_session *session,
 	session->s_cap_iterator = NULL;
 	spin_unlock(&session->s_cap_lock);
 
-	iput(last_inode);
+	ceph_iput_async(last_inode);
 	if (old_cap)
 		ceph_put_cap(session->s_mdsc, old_cap);
 
@@ -1904,7 +1904,7 @@ static int remove_session_caps_cb(struct inode *inode, int mds, void *arg)
 	if (invalidate)
 		ceph_queue_invalidate(inode);
 	while (iputs--)
-		iput(inode);
+		ceph_iput_async(inode);
 	return 0;
 }
 
@@ -1944,7 +1944,7 @@ static void remove_session_caps(struct ceph_mds_session *session)
 			spin_unlock(&session->s_cap_lock);
 
 			inode = ceph_find_inode(sb, vino);
-			iput(inode);
+			ceph_iput_async(inode);
 
 			spin_lock(&session->s_cap_lock);
 		}
@@ -2512,7 +2512,7 @@ static void ceph_cap_unlink_work(struct work_struct *work)
 			doutc(cl, "on %p %llx.%llx\n", inode,
 			      ceph_vinop(inode));
 			ceph_check_caps(ci, CHECK_CAPS_FLUSH);
-			iput(inode);
+			ceph_iput_async(inode);
 			spin_lock(&mdsc->cap_delay_lock);
 		}
 	}
@@ -3933,7 +3933,7 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 		    !req->r_reply_info.has_create_ino) {
 			/* This should never happen on an async create */
 			WARN_ON_ONCE(req->r_deleg_ino);
-			iput(in);
+			ceph_iput_async(in);
 			in = NULL;
 		}
 
@@ -5313,7 +5313,7 @@ static void handle_lease(struct ceph_mds_client *mdsc,
 
 out:
 	mutex_unlock(&session->s_mutex);
-	iput(inode);
+	ceph_iput_async(inode);
 
 	ceph_dec_mds_stopping_blocker(mdsc);
 	return;
diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
index d90eda19bcc4..bba00f8926e6 100644
--- a/fs/ceph/quota.c
+++ b/fs/ceph/quota.c
@@ -76,7 +76,7 @@ void ceph_handle_quota(struct ceph_mds_client *mdsc,
 		            le64_to_cpu(h->max_files));
 	spin_unlock(&ci->i_ceph_lock);
 
-	iput(inode);
+	ceph_iput_async(inode);
 out:
 	ceph_dec_mds_stopping_blocker(mdsc);
 }
@@ -190,7 +190,7 @@ void ceph_cleanup_quotarealms_inodes(struct ceph_mds_client *mdsc)
 		node = rb_first(&mdsc->quotarealms_inodes);
 		qri = rb_entry(node, struct ceph_quotarealm_inode, node);
 		rb_erase(node, &mdsc->quotarealms_inodes);
-		iput(qri->inode);
+		ceph_iput_async(qri->inode);
 		kfree(qri);
 	}
 	mutex_unlock(&mdsc->quotarealms_inodes_mutex);
diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index c65f2b202b2b..19f097e79b3c 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -735,7 +735,7 @@ static void queue_realm_cap_snaps(struct ceph_mds_client *mdsc,
 		if (!inode)
 			continue;
 		spin_unlock(&realm->inodes_with_caps_lock);
-		iput(lastinode);
+		ceph_iput_async(lastinode);
 		lastinode = inode;
 
 		/*
@@ -762,7 +762,7 @@ static void queue_realm_cap_snaps(struct ceph_mds_client *mdsc,
 		spin_lock(&realm->inodes_with_caps_lock);
 	}
 	spin_unlock(&realm->inodes_with_caps_lock);
-	iput(lastinode);
+	ceph_iput_async(lastinode);
 
 	if (capsnap)
 		kmem_cache_free(ceph_cap_snap_cachep, capsnap);
@@ -955,7 +955,7 @@ static void flush_snaps(struct ceph_mds_client *mdsc)
 		ihold(inode);
 		spin_unlock(&mdsc->snap_flush_lock);
 		ceph_flush_snaps(ci, &session);
-		iput(inode);
+		ceph_iput_async(inode);
 		spin_lock(&mdsc->snap_flush_lock);
 	}
 	spin_unlock(&mdsc->snap_flush_lock);
@@ -1116,12 +1116,12 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
 			ceph_get_snap_realm(mdsc, realm);
 			ceph_change_snap_realm(inode, realm);
 			spin_unlock(&ci->i_ceph_lock);
-			iput(inode);
+			ceph_iput_async(inode);
 			continue;
 
 skip_inode:
 			spin_unlock(&ci->i_ceph_lock);
-			iput(inode);
+			ceph_iput_async(inode);
 		}
 
 		/* we may have taken some of the old realm's children. */
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index cf176aab0f82..361a72a67bb8 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1085,6 +1085,8 @@ static inline void ceph_queue_flush_snaps(struct inode *inode)
 	ceph_queue_inode_work(inode, CEPH_I_WORK_FLUSH_SNAPS);
 }
 
+void ceph_iput_async(struct inode *inode);
+
 extern int ceph_try_to_choose_auth_mds(struct inode *inode, int mask);
 extern int __ceph_do_getattr(struct inode *inode, struct page *locked_page,
 			     int mask, bool force);
-- 
2.47.3

