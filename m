Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43812AF1D
	for <netfs@lists.linux.dev>; Sun, 23 Mar 2025 20:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742760199; cv=none; b=Qr3iCkzDT9pHd3hfEq0VDjqsu+331F7Ylpb7Oc4nJuLvgDPB4vd6OlCBWEzaor8v0GRFT/ZdIgT+YgZCoWSl30mjMsachXiDv2KSadSPqwBnhCyA4t3eJJMMtP3RdsRJqnJB0aLNJt8/Lf5ZtAVE8hxD/HUcavyXKc4MUK/swd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742760199; c=relaxed/simple;
	bh=rwZPZTwPS4r7v6W5+VAKtKZSDLHg9y/9IgIloVL6og4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XqntVuXGQbgYUWBKozIaOI88W/8kLRnj050VV07I99AYplPStQ/7//7/0lRaZX0HP9WF6J94pkyGK5iiI5Zr9CqoqcEOMFdptLWINcy4ZrZzc3r/EqksC+Pk5KlgjLSMJ4VaAy0Z8aALjnDH2Yj0dz3FALG2JrgmTn94WB1yNMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbG4Zqts; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbG4Zqts"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43948021a45so29413265e9.1
        for <netfs@lists.linux.dev>; Sun, 23 Mar 2025 13:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742760194; x=1743364994; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aGft5Et35KBhKNEX4bnKsS2M813r08vXuvkuA76ff7I=;
        b=DbG4Zqtsjwa+8ztHkhK+1I+KhnfijpFxnu7FZRVkn6RFvVmwLB2fmhTd38yTfE4MDk
         rh74aszVJhSDswWRoud3adnzzXiLLOFcezF1oe7jNZ9E7ZU0a7DeJFsc0iAIA7uq/waO
         3OKNq8x6ERSfEy0IUeH5b1tgGgnPwsW9u5keYj/K1cwZr0Xa7+0oqsld3/wc06DAe1++
         S6Ukqpa7jMfJBVEieiEiPz3lBBcUbetJHLtS33e13VGk50qGZ0S5z1PrYxmRj/Olbtxc
         AlOrau+ihp4sHLuP+xQUcB2SSPEPUy5+eQp3anepUZXTw/YTy8zDAbJggy8+L7ZtJi+i
         uqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742760194; x=1743364994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGft5Et35KBhKNEX4bnKsS2M813r08vXuvkuA76ff7I=;
        b=Lss1LKZ5VOj4zErycBOHwJ7YgWhLG5xkGFK4lX2tNywlTzzFlUhEqMw2SY1oIYRY/L
         PpynXnSCkmavm7/TyTb9RQRmd4wQrreDUotzPskV6Bq0G2o8U7LpQeNYDrBdX/iDiTxV
         EAblJ9EvhTk/KXACD5ACx4D7M6pwZTNrHEbBMsYgXyVBzv9uHofPpWq7jNZmzMONW7YA
         ZphJlG/iMQGNdzL3E3aOZAT1zirp0v8uOCZkck7opV0ymP6btI6NT5KrAQTdK+PYSN5z
         EU/g1si29QOSDaV9TLlO44ihz0mOBxXQe7jBVzrvy0aGLz4EXPOOHLKdXrU/iiZWIuky
         NuNg==
X-Forwarded-Encrypted: i=1; AJvYcCWkrqSuGOeSh8Kgl8IgYtSomAmshPnK+mrlK77ZMCe0sdYb1lnV8WuFfCQY8tF/Ff9hWp2xMg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw8DFh2hb52oANgrZ3ndd7Q7EVbYpzSR2FhAlYN8EOqpTPd+uQK
	VoG2i5FIP/usSrGSaUkiN8PlgPBEa/jwS5SzMs6CJlIF0cI1eAde
X-Gm-Gg: ASbGncs2fwhFgGItxKqqiIevvWNUYn7K1tPC8/4Xsxzp0oGtNVGCQj5D+JHUTIKGJrw
	uIFsCxGMhrk529VPM4DbrAgCiYTf/wTmZ7OeJ9TvOCqAzUOgBwJIlM3+DcZqFum9shcNCL0B+Zu
	x71LXQ42G1rdlcJhMkW0YCx52h51krUOBjryf36qx/ren4rNwzH8vvbays84MBwnDiuIj1jLwog
	nhHVwAzc+469+6OndO/3RtsJtPDOLjkuUdiYhXvv+qSvZPMq9j9QB3S+kymuMZ8KlGJmGBpuKLA
	A3gTdmd+cI3aMbY3DvNC6X+mk0n3UaXKSur8D3GehNq+gw8m2EUbCYu+zwUU
X-Google-Smtp-Source: AGHT+IHxC8eJ61S2vO5ZLyASbUzR3esC5aD0WxTSRyk1ncB2aHbentG4dmbxdka8YNFZsKOSN1yAkw==
X-Received: by 2002:a05:600c:5742:b0:43c:e70d:44f0 with SMTP id 5b1f17b1804b1-43d510fff60mr71296195e9.19.1742760193891;
        Sun, 23 Mar 2025 13:03:13 -0700 (PDT)
Received: from f (cst-prg-82-128.cust.vodafone.cz. [46.135.82.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd9e96bsm98053895e9.25.2025.03.23.13.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 13:03:13 -0700 (PDT)
Date: Sun, 23 Mar 2025 21:03:00 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, dhowells@redhat.com, jack@suse.cz, 
	jlayton@kernel.org, kprateek.nayak@amd.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, oleg@redhat.com, swapnil.sapkal@amd.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
Message-ID: <cqyyq5vbtxbz3cpvgdy4hupy3eykhv5fzc46aehgjnk2lifda4@w3jnwtvigvoh>
References: <20250323184848.GB14883@redhat.com>
 <67e05e30.050a0220.21942d.0003.GAE@google.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <67e05e30.050a0220.21942d.0003.GAE@google.com>

> Tested on:
> 
> commit:         aaec5a95 pipe_read: don't wake up the writer if the pi..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> console output: https://syzkaller.appspot.com/x/log.txt?x=169ac43f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8d5a2956e94d7972
> dashboard link: https://syzkaller.appspot.com/bug?extid=62262fdc0e01d99573fc
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=17803c4c580000
> 

Here is a "just in case" by me: the patch which made sure to only look
at head + tail with the lock held.

#syz test: upstream aaec5a95d59615523db03dd53c2052f0a87beea7

diff --git a/fs/pipe.c b/fs/pipe.c
index 82fede0f2111..7eedcef2811e 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -210,11 +210,20 @@ static const struct pipe_buf_operations anon_pipe_buf_ops = {
 /* Done while waiting without holding the pipe lock - thus the READ_ONCE() */
 static inline bool pipe_readable(const struct pipe_inode_info *pipe)
 {
-	unsigned int head = READ_ONCE(pipe->head);
-	unsigned int tail = READ_ONCE(pipe->tail);
-	unsigned int writers = READ_ONCE(pipe->writers);
+	return !READ_ONCE(pipe->isempty) || !READ_ONCE(pipe->writers);
+}
+
+static inline void pipe_recalc_state(struct pipe_inode_info *pipe)
+{
+	pipe->isempty = pipe_empty(pipe->head, pipe->tail);
+	pipe->isfull = pipe_full(pipe->head, pipe->tail, pipe->max_usage);
+}
 
-	return !pipe_empty(head, tail) || !writers;
+static inline void pipe_update_head(struct pipe_inode_info *pipe,
+				    unsigned int head)
+{
+	pipe->head = ++head;
+	pipe_recalc_state(pipe);
 }
 
 static inline unsigned int pipe_update_tail(struct pipe_inode_info *pipe,
@@ -244,6 +253,7 @@ static inline unsigned int pipe_update_tail(struct pipe_inode_info *pipe,
 	 * without the spinlock - the mutex is enough.
 	 */
 	pipe->tail = ++tail;
+	pipe_recalc_state(pipe);
 	return tail;
 }
 
@@ -417,12 +427,7 @@ static inline int is_packetized(struct file *file)
 /* Done while waiting without holding the pipe lock - thus the READ_ONCE() */
 static inline bool pipe_writable(const struct pipe_inode_info *pipe)
 {
-	unsigned int head = READ_ONCE(pipe->head);
-	unsigned int tail = READ_ONCE(pipe->tail);
-	unsigned int max_usage = READ_ONCE(pipe->max_usage);
-
-	return !pipe_full(head, tail, max_usage) ||
-		!READ_ONCE(pipe->readers);
+	return !READ_ONCE(pipe->isfull) || !READ_ONCE(pipe->readers);
 }
 
 static ssize_t
@@ -524,7 +529,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 			 * it, either the reader will consume it or it'll still
 			 * be there for the next write.
 			 */
-			pipe->head = head + 1;
+			pipe_update_head(pipe, head);
 
 			/* Insert it into the buffer array */
 			buf = &pipe->bufs[head & mask];
@@ -549,10 +554,9 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 
 			if (!iov_iter_count(from))
 				break;
-		}
 
-		if (!pipe_full(head, pipe->tail, pipe->max_usage))
 			continue;
+		}
 
 		/* Wait for buffer space to become available. */
 		if ((filp->f_flags & O_NONBLOCK) ||
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index 8ff23bf5a819..d4b7539399b5 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -69,6 +69,8 @@ struct pipe_inode_info {
 	unsigned int r_counter;
 	unsigned int w_counter;
 	bool poll_usage;
+	bool isempty;
+	bool isfull;
 #ifdef CONFIG_WATCH_QUEUE
 	bool note_loss;
 #endif
