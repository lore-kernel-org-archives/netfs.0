Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B2C17B507;
	Fri, 30 Aug 2024 10:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725013008; cv=none; b=mZZblfMO7z2pbNJDtQwld1nWqvQwoBvrKkfbq8edOXBULvJg2SDe7QAAcOyYeoHFyJxsVVxqMN/wth+o3MCyDKN8fjnpmo7WK6doJ/aZQ4GTF5gYFt0ybspAtVLVG0ESebfUPVD1G9jM2mQugsB7vBNf9q9MeNy74X83c6iiM20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725013008; c=relaxed/simple;
	bh=s60eTLrXL5WjQZzadGCrNRG64xw3ll5H3SgMy1fb9Y4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mde7ns9/SME+9RdzMbYHPCZ3G2n1RidoVy5yXVUFJ8ou4PW1g3+apUX+i6h48/YBZAW8NivHsTo6WZ4gpR99naNDZ2gPUCiCPfvQ1vgJpX86eJqh9As5ika6v4LlZ6OS/rh0uFLC57Bt740UBNCCI9gV2N9O5Jwrhbyrwj06h18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zL2zFTmF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zL2zFTmF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F6BC4CEC6;
	Fri, 30 Aug 2024 10:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725013008;
	bh=s60eTLrXL5WjQZzadGCrNRG64xw3ll5H3SgMy1fb9Y4=;
	h=Subject:To:Cc:From:Date:From;
	b=zL2zFTmFAI0if4Anv3PVuUEpj0hqUh0Rj0br7GWjtvK6iutHt7BopSLoO7OUV9njw
	 wPis8+s0jDBzKoBQy3uyVo3LdfdyZoHGwOQSzwbnCSkv462/WpqM6dZZKAD1Xdbdwe
	 enbnbWfM06NSyH/MXjxWWCOnuY3PtJUQlwdpIhQk=
Subject: Patch "netfs, ceph: Partially revert "netfs: Replace PG_fscache by setting folio->private and marking dirty"" has been added to the 6.10-stable tree
To: brauner@kernel.org,dhowells@redhat.com,gregkh@linuxfoundation.org,idryomov@gmail.com,jlayton@kernel.org,linux-mm@kvack.org,max.kellermann@ionos.com,netfs@lists.linux.dev,willy@infradead.org,xiubli@redhat.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 30 Aug 2024 12:16:44 +0200
Message-ID: <2024083044-preview-cornstalk-80e9@gregkh>
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

    netfs, ceph: Partially revert "netfs: Replace PG_fscache by setting folio->private and marking dirty"

to the 6.10-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     netfs-ceph-partially-revert-netfs-replace-pg_fscache-by-setting-folio-private-and-marking-dirty.patch
and it can be found in the queue-6.10 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From 92764e8822d4e7f8efb5ad959fac195a7f8ea0c6 Mon Sep 17 00:00:00 2001
From: David Howells <dhowells@redhat.com>
Date: Wed, 14 Aug 2024 21:38:21 +0100
Subject: netfs, ceph: Partially revert "netfs: Replace PG_fscache by setting folio->private and marking dirty"

From: David Howells <dhowells@redhat.com>

commit 92764e8822d4e7f8efb5ad959fac195a7f8ea0c6 upstream.

This partially reverts commit 2ff1e97587f4d398686f52c07afde3faf3da4e5c.

In addition to reverting the removal of PG_private_2 wrangling from the
buffered read code[1][2], the removal of the waits for PG_private_2 from
netfs_release_folio() and netfs_invalidate_folio() need reverting too.

It also adds a wait into ceph_evict_inode() to wait for netfs read and
copy-to-cache ops to complete.

Fixes: 2ff1e97587f4 ("netfs: Replace PG_fscache by setting folio->private and marking dirty")
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/3575457.1722355300@warthog.procyon.org.uk [1]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8e5ced7804cb9184c4a23f8054551240562a8eda [2]
Link: https://lore.kernel.org/r/20240814203850.2240469-2-dhowells@redhat.com
cc: Max Kellermann <max.kellermann@ionos.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Xiubo Li <xiubli@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: ceph-devel@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ceph/inode.c |    1 +
 fs/netfs/misc.c |    7 +++++++
 2 files changed, 8 insertions(+)

--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -697,6 +697,7 @@ void ceph_evict_inode(struct inode *inod
 
 	percpu_counter_dec(&mdsc->metric.total_inodes);
 
+	netfs_wait_for_outstanding_io(inode);
 	truncate_inode_pages_final(&inode->i_data);
 	if (inode->i_state & I_PINNING_NETFS_WB)
 		ceph_fscache_unuse_cookie(inode, true);
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -101,6 +101,8 @@ void netfs_invalidate_folio(struct folio
 
 	kenter("{%lx},%zx,%zx", folio->index, offset, length);
 
+	folio_wait_private_2(folio); /* [DEPRECATED] */
+
 	if (!folio_test_private(folio))
 		return;
 
@@ -165,6 +167,11 @@ bool netfs_release_folio(struct folio *f
 
 	if (folio_test_private(folio))
 		return false;
+	if (unlikely(folio_test_private_2(folio))) { /* [DEPRECATED] */
+		if (current_is_kswapd() || !(gfp & __GFP_FS))
+			return false;
+		folio_wait_private_2(folio);
+	}
 	fscache_note_page_release(netfs_i_cookie(ctx));
 	return true;
 }


Patches currently in stable-queue which might be from dhowells@redhat.com are

queue-6.10/smb-client-avoid-dereferencing-rdata-null-in-smb2_new_read_req.patch
queue-6.10/netfs-ceph-partially-revert-netfs-replace-pg_fscache-by-setting-folio-private-and-marking-dirty.patch
