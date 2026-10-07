Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119253CFF4C;
	Wed,  7 Oct 2026 08:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791362552; cv=none; b=RKbyd+pDQ+/4CDCuIvJqPxBb0TNd3nZPsTx++90tPnkZvdNlwwIzWuG7bdieCyleyXFzVApaJzHMyfGnmBG83S4RWh7jHIk9b7TuwW5br23ILGoby1JWHd+nZymy2OPmfhv1PmaymTv6MXzJgl84iRY5e9cHcYl6rYejonR1yHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791362552; c=relaxed/simple;
	bh=cRsF+NLNACe3s8wVkY3WEoFqpRhxhdQW/vixnLoBn58=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VbfYuTu3r+IWBVAXl6TokdY+3Qfi+F+3NC/YFeXCi82q0kwBITohwDbB7v6ZtYcq44b2EG3OdFTeFjKFO615FmOcy47by2NgLxZ//dHDGxys/Xt0+z2Ninte7y6ZYNYlyzxpDaRvOsyUtBHEBoduofUxyeQQO6iC+KPUBIQO4ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jRmzY7qN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jRmzY7qN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21BA81F0089B;
	Wed,  7 Oct 2026 08:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791362550;
	bh=+EtyAFIfKbHUPY3d568LrwzfXzV9jhoOYO0OFwglHPM=;
	h=Subject:To:Cc:From:Date;
	b=jRmzY7qNR8WJVhkXzQ+9mIoYwtuxzE/VWsWUqUmhU9EJQo6nNjLFMJW4swmFVdilR
	 mOp/uX+hc1KrSW89QzArJS73hbocqoPS6km11oqoDOp6hkA3SEDRdAeUgmsmOydSAO
	 sRGlgl8OsjU7xRdlpgU7dA5QwFwVsvUEkYVsYZT4=
Subject: Patch "cifs: Fix handling of a beyond-EOF DIO/unbuffered read over SMB1" has been added to the 6.12-stable tree
To: dhowells@redhat.com,gregkh@linuxfoundation.org,mmirkin@nppct.ru,netfs@lists.linux.dev,pc@manguebit.org,sprasad@microsoft.com,stfrench@microsoft.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 07 Oct 2026 10:41:18 +0200
Message-ID: <2026100718-protrude-reassign-9d93@gregkh>
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

    cifs: Fix handling of a beyond-EOF DIO/unbuffered read over SMB1

to the 6.12-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     cifs-fix-handling-of-a-beyond-eof-dio-unbuffered-read-over-smb1.patch
and it can be found in the queue-6.12 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From 9d85ac939d52e93d80efb01a299c6f0bedb30487 Mon Sep 17 00:00:00 2001
From: David Howells <dhowells@redhat.com>
Date: Tue, 2 Dec 2025 16:24:53 +0000
Subject: cifs: Fix handling of a beyond-EOF DIO/unbuffered read over SMB1

From: David Howells <dhowells@redhat.com>

commit 9d85ac939d52e93d80efb01a299c6f0bedb30487 upstream.

If a DIO read or an unbuffered read request extends beyond the EOF, the
server will return a short read and a status code indicating that EOF was
hit, which gets translated to -ENODATA.  Note that the client does not cap
the request at i_size, but asks for the amount requested in case there's a
race on the server with a third party.

Now, on the client side, the request will get split into multiple
subrequests if rsize is smaller than the full request size.  A subrequest
that starts before or at the EOF and returns short data up to the EOF will
be correctly handled, with the NETFS_SREQ_HIT_EOF flag being set,
indicating to netfslib that we can't read more.

If a subrequest, however, starts after the EOF and not at it, HIT_EOF will
not be flagged, its error will be set to -ENODATA and it will be abandoned.
This will cause the request as a whole to fail with -ENODATA.

Fix this by setting NETFS_SREQ_HIT_EOF on any subrequest that lies beyond
the EOF marker.

This can be reproduced by mounting with "cache=none,sign,vers=1.0" and
doing a read of a file that's significantly bigger than the size of the
file (e.g. attempting to read 64KiB from a 16KiB file).

Fixes: a68c74865f51 ("cifs: Fix SMB1 readv/writev callback in the same way as SMB2/3")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
[Mikhail Mirkin: Adopted for 6.12]
Signed-off-by: Mikhail Mirkin <mmirkin@nppct.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/cifssmb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -1321,7 +1321,7 @@ cifs_readv_callback(struct mid_q_entry *
 	} else {
 		size_t trans = rdata->subreq.transferred + rdata->got_bytes;
 		if (trans < rdata->subreq.len &&
-		    rdata->subreq.start + trans == ictx->remote_i_size) {
+		    rdata->subreq.start + trans >= ictx->remote_i_size) {
 			__set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
 			rdata->result = 0;
 		}


Patches currently in stable-queue which might be from dhowells@redhat.com are

queue-6.12/smb-client-discard-post-eof-pagecache-when-extending-a-file-via-copy-range.patch
queue-6.12/smb-client-discard-post-eof-pagecache-when-extending-a-file-via-zero-range.patch
queue-6.12/cifs-fix-handling-of-a-beyond-eof-dio-unbuffered-read-over-smb1.patch
queue-6.12/netfs-clear-post-eof-pagecache-when-extending-a-file.patch
