Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C120C1A3035;
	Wed, 19 Mar 2025 14:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394133; cv=none; b=K5AJ7djHPnOozV+DsGqX0SVTI9eFEy3qKtpklc7Vd9/rgq8BHW1+gBbkr+8mS6rDJdn9hMENWNLhQlYFiHFJ1K/jcIZV88eqCSPp0hDy3fqJVoD4igvBhEKZ+Us8rBGWgadjFTZiyWqx0WdEBReMfsBkywleYcC1fD7t9qaqzqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394133; c=relaxed/simple;
	bh=H+gN1AibjtcsEJf9piaM0d1tmgVMeXaJuGgkrc7LZE8=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=qnPrq0PybXJKqeaRPWEsXlW+otHAkqGDANM/tsvAWEX/GFCvTxOb+e/ImjW1amhRq0EvHT4yCndpAfrn+H0GAL5OHZ9x3Ifluf5EoUNgIKSGK0/KvaCMGl5yXTVbfzaJMtuwBHJRAqF1e9nkt8zQhA+j0wMt47/0eJISdecOV6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sjfsFcFz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sjfsFcFz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F5AC4CEE4;
	Wed, 19 Mar 2025 14:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742394133;
	bh=H+gN1AibjtcsEJf9piaM0d1tmgVMeXaJuGgkrc7LZE8=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=sjfsFcFzsME8IiiETsJnTSCFGM3SF4AfsLh5Uqxn+Jc3+9G9JoLQoFNKRIZ2F5Rvz
	 gOLFmhsFlQr1vWpIohUuASQqKYV7F0d1KlLu3Do8sItoe9vzipkeNlHUDIn98ifjn6
	 OaG2TlIR57bTHMyIA3LhkK4Fsjtf8w/vOThvX9PI=
Subject: Patch "fs/netfs/read_collect: add to next->prev_donated" has been added to the 6.13-stable tree
To: dhowells@redhat.com,gregkh@linuxfoundation.org,max.kellermann@ionos.com,netfs@lists.linux.dev
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Mar 2025 07:20:53 -0700
In-Reply-To: <20250220152450.1075727-1-max.kellermann@ionos.com>
Message-ID: <2025031953-hunter-litter-778a@gregkh>
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

    fs/netfs/read_collect: add to next->prev_donated

to the 6.13-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     fs-netfs-read_collect-add-to-next-prev_donated.patch
and it can be found in the queue-6.13 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-118455-greg=kroah.com@vger.kernel.org Thu Feb 20 07:27:34 2025
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 20 Feb 2025 16:24:50 +0100
Subject: fs/netfs/read_collect: add to next->prev_donated
To: dhowells@redhat.com, netfs@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>, stable@vger.kernel.org
Message-ID: <20250220152450.1075727-1-max.kellermann@ionos.com>

From: Max Kellermann <max.kellermann@ionos.com>

If multiple subrequests donate data to the same "next" request
(depending on the subrequest completion order), each of them would
overwrite the `prev_donated` field, causing data corruption and a
BUG() crash ("Can't donate prior to front").

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Closes: https://lore.kernel.org/netfs/CAKPOu+_4mUwYgQtRTbXCmi+-k3PGvLysnPadkmHOyB7Gz0iSMA@mail.gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/netfs/read_collect.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -284,7 +284,7 @@ donation_changed:
 				   netfs_trace_donate_to_deferred_next);
 	} else {
 		next = list_next_entry(subreq, rreq_link);
-		WRITE_ONCE(next->prev_donated, excess);
+		WRITE_ONCE(next->prev_donated, next->prev_donated + excess);
 		trace_netfs_donate(rreq, subreq, next, excess,
 				   netfs_trace_donate_to_next);
 	}


Patches currently in stable-queue which might be from max.kellermann@ionos.com are

queue-6.13/fs-netfs-read_collect-add-to-next-prev_donated.patch
