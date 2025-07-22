Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6C12E92BF;
	Tue, 22 Jul 2025 12:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753186908; cv=none; b=EtquQGNjwBRqKnkF24FJXAb06Dz7r80cSSkr1gQWdERUE0DCbpEtgmNXCOgtQEAQg5Ct/5Hue12Nknl0W7VGWpg0VheI+0A4EoyeTINJMjCJIBIOkfNcNPKo3J/aw0id+Plq6HprgUpqxftFvN6Xmzah/Lgot99F0R/F10BRzts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753186908; c=relaxed/simple;
	bh=5CpsevvFoDih+qUoSaNPn6Lm2XdGdY4o9QNftor+2O8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oB2DklTKF4jI32gj9G4oMSj6jRE8loyEkza9TUEuT2IEF3v/k+hl0G41voZADH4RKd/fHO32HtTj/9B9OqzOwTjp9M7qxhjC4XZrDNW7yp/IBPsg16Ri+C3hz++JtD0ayN3ZEkVvlgToFHOHToZFg6MQtCKhWdOY3Ph2thcrr/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zlC5CkfK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zlC5CkfK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43771C4CEEB;
	Tue, 22 Jul 2025 12:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753186907;
	bh=5CpsevvFoDih+qUoSaNPn6Lm2XdGdY4o9QNftor+2O8=;
	h=Subject:To:Cc:From:Date:From;
	b=zlC5CkfKkw/B4oCVjIx75lFBH8xC5d6609kavwvVcpuojHek06Y4CfUgWHTY1Mozq
	 6BEL36OlIFZ1lOzvUnqkNH/dF3YppNnkwqneS1nZl2xeyq2hKlaMYJTNUylFusWPNC
	 31e9KtxlAa3QTAIBTEq3xbBKgx1R1wskEFcMTohA=
Subject: Patch "cifs: Fix reading into an ITER_FOLIOQ from the smbdirect code" has been added to the 6.15-stable tree
To: dhowells@redhat.com,gregkh@linuxfoundation.org,metze@samba.org,netfs@lists.linux.dev,pc@manguebit.com,stfrench@microsoft.com,tom@talpey.com,willy@infradead.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Jul 2025 14:21:44 +0200
Message-ID: <2025072244-scowling-amicably-bf1e@gregkh>
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

    cifs: Fix reading into an ITER_FOLIOQ from the smbdirect code

to the 6.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     cifs-fix-reading-into-an-iter_folioq-from-the-smbdirect-code.patch
and it can be found in the queue-6.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From 263debecb4aa7cec0a86487e6f409814f6194a21 Mon Sep 17 00:00:00 2001
From: David Howells <dhowells@redhat.com>
Date: Wed, 2 Apr 2025 20:27:26 +0100
Subject: cifs: Fix reading into an ITER_FOLIOQ from the smbdirect code

From: David Howells <dhowells@redhat.com>

commit 263debecb4aa7cec0a86487e6f409814f6194a21 upstream.

When performing a file read from RDMA, smbd_recv() prints an "Invalid msg
type 4" error and fails the I/O.  This is due to the switch-statement there
not handling the ITER_FOLIOQ handed down from netfslib.

Fix this by collapsing smbd_recv_buf() and smbd_recv_page() into
smbd_recv() and just using copy_to_iter() instead of memcpy().  This
future-proofs the function too, in case more ITER_* types are added.

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Reported-by: Stefan Metzmacher <metze@samba.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Tom Talpey <tom@talpey.com>
cc: Paulo Alcantara (Red Hat) <pc@manguebit.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/smbdirect.c |  112 ++++++----------------------------------------
 1 file changed, 17 insertions(+), 95 deletions(-)

--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -1755,35 +1755,39 @@ try_again:
 }
 
 /*
- * Receive data from receive reassembly queue
+ * Receive data from the transport's receive reassembly queue
  * All the incoming data packets are placed in reassembly queue
- * buf: the buffer to read data into
+ * iter: the buffer to read data into
  * size: the length of data to read
  * return value: actual data read
- * Note: this implementation copies the data from reassebmly queue to receive
+ *
+ * Note: this implementation copies the data from reassembly queue to receive
  * buffers used by upper layer. This is not the optimal code path. A better way
  * to do it is to not have upper layer allocate its receive buffers but rather
  * borrow the buffer from reassembly queue, and return it after data is
  * consumed. But this will require more changes to upper layer code, and also
  * need to consider packet boundaries while they still being reassembled.
  */
-static int smbd_recv_buf(struct smbd_connection *info, char *buf,
-		unsigned int size)
+int smbd_recv(struct smbd_connection *info, struct msghdr *msg)
 {
 	struct smbdirect_socket *sc = &info->socket;
 	struct smbd_response *response;
 	struct smbdirect_data_transfer *data_transfer;
+	size_t size = iov_iter_count(&msg->msg_iter);
 	int to_copy, to_read, data_read, offset;
 	u32 data_length, remaining_data_length, data_offset;
 	int rc;
 
+	if (WARN_ON_ONCE(iov_iter_rw(&msg->msg_iter) == WRITE))
+		return -EINVAL; /* It's a bug in upper layer to get there */
+
 again:
 	/*
 	 * No need to hold the reassembly queue lock all the time as we are
 	 * the only one reading from the front of the queue. The transport
 	 * may add more entries to the back of the queue at the same time
 	 */
-	log_read(INFO, "size=%d info->reassembly_data_length=%d\n", size,
+	log_read(INFO, "size=%zd info->reassembly_data_length=%d\n", size,
 		info->reassembly_data_length);
 	if (info->reassembly_data_length >= size) {
 		int queue_length;
@@ -1821,7 +1825,10 @@ again:
 			if (response->first_segment && size == 4) {
 				unsigned int rfc1002_len =
 					data_length + remaining_data_length;
-				*((__be32 *)buf) = cpu_to_be32(rfc1002_len);
+				__be32 rfc1002_hdr = cpu_to_be32(rfc1002_len);
+				if (copy_to_iter(&rfc1002_hdr, sizeof(rfc1002_hdr),
+						 &msg->msg_iter) != sizeof(rfc1002_hdr))
+					return -EFAULT;
 				data_read = 4;
 				response->first_segment = false;
 				log_read(INFO, "returning rfc1002 length %d\n",
@@ -1830,10 +1837,9 @@ again:
 			}
 
 			to_copy = min_t(int, data_length - offset, to_read);
-			memcpy(
-				buf + data_read,
-				(char *)data_transfer + data_offset + offset,
-				to_copy);
+			if (copy_to_iter((char *)data_transfer + data_offset + offset,
+					 to_copy, &msg->msg_iter) != to_copy)
+				return -EFAULT;
 
 			/* move on to the next buffer? */
 			if (to_copy == data_length - offset) {
@@ -1899,90 +1905,6 @@ read_rfc1002_done:
 }
 
 /*
- * Receive a page from receive reassembly queue
- * page: the page to read data into
- * to_read: the length of data to read
- * return value: actual data read
- */
-static int smbd_recv_page(struct smbd_connection *info,
-		struct page *page, unsigned int page_offset,
-		unsigned int to_read)
-{
-	struct smbdirect_socket *sc = &info->socket;
-	int ret;
-	char *to_address;
-	void *page_address;
-
-	/* make sure we have the page ready for read */
-	ret = wait_event_interruptible(
-		info->wait_reassembly_queue,
-		info->reassembly_data_length >= to_read ||
-			sc->status != SMBDIRECT_SOCKET_CONNECTED);
-	if (ret)
-		return ret;
-
-	/* now we can read from reassembly queue and not sleep */
-	page_address = kmap_atomic(page);
-	to_address = (char *) page_address + page_offset;
-
-	log_read(INFO, "reading from page=%p address=%p to_read=%d\n",
-		page, to_address, to_read);
-
-	ret = smbd_recv_buf(info, to_address, to_read);
-	kunmap_atomic(page_address);
-
-	return ret;
-}
-
-/*
- * Receive data from transport
- * msg: a msghdr point to the buffer, can be ITER_KVEC or ITER_BVEC
- * return: total bytes read, or 0. SMB Direct will not do partial read.
- */
-int smbd_recv(struct smbd_connection *info, struct msghdr *msg)
-{
-	char *buf;
-	struct page *page;
-	unsigned int to_read, page_offset;
-	int rc;
-
-	if (iov_iter_rw(&msg->msg_iter) == WRITE) {
-		/* It's a bug in upper layer to get there */
-		cifs_dbg(VFS, "Invalid msg iter dir %u\n",
-			 iov_iter_rw(&msg->msg_iter));
-		rc = -EINVAL;
-		goto out;
-	}
-
-	switch (iov_iter_type(&msg->msg_iter)) {
-	case ITER_KVEC:
-		buf = msg->msg_iter.kvec->iov_base;
-		to_read = msg->msg_iter.kvec->iov_len;
-		rc = smbd_recv_buf(info, buf, to_read);
-		break;
-
-	case ITER_BVEC:
-		page = msg->msg_iter.bvec->bv_page;
-		page_offset = msg->msg_iter.bvec->bv_offset;
-		to_read = msg->msg_iter.bvec->bv_len;
-		rc = smbd_recv_page(info, page, page_offset, to_read);
-		break;
-
-	default:
-		/* It's a bug in upper layer to get there */
-		cifs_dbg(VFS, "Invalid msg type %d\n",
-			 iov_iter_type(&msg->msg_iter));
-		rc = -EINVAL;
-	}
-
-out:
-	/* SMBDirect will read it all or nothing */
-	if (rc > 0)
-		msg->msg_iter.count = 0;
-	return rc;
-}
-
-/*
  * Send data to transport
  * Each rqst is transported as a SMBDirect payload
  * rqst: the data to write


Patches currently in stable-queue which might be from dhowells@redhat.com are

queue-6.15/cifs-fix-reading-into-an-iter_folioq-from-the-smbdirect-code.patch
queue-6.15/rxrpc-fix-to-use-conn-aborts-for-conn-wide-failures.patch
queue-6.15/rxrpc-fix-irq-disabled-in-local_bh_enable.patch
queue-6.15/netfs-fix-copy-to-cache-so-that-it-performs-collection-with-ceph-fscache.patch
queue-6.15/rxrpc-fix-notification-vs-call-release-vs-recvmsg.patch
queue-6.15/cifs-fix-the-smbd_response-slab-to-allow-usercopy.patch
queue-6.15/rxrpc-fix-transmission-of-an-abort-in-response-to-an.patch
queue-6.15/netfs-fix-race-between-cache-write-completion-and-all_queued-being-set.patch
queue-6.15/rxrpc-fix-recv-recv-race-of-completed-call.patch
