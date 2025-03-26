Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224481E5B96
	for <netfs@lists.linux.dev>; Wed, 26 Mar 2025 12:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742993099; cv=none; b=RM6Hzvmn2L/dC4ytrCKaY+0sCQjKFkIeLc4ytVlOU9L4mra+XisspoLdPqgrNDaO08hpk7C2JvryeNE3pknv2l21xPqsAVOHE4IeYry0IY80xWU0KoWt6y5OM2QFn8aEnb5Dhq9s4Of/x/Z4ydHOm6xokhTWLcR74x1LGFOn1F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742993099; c=relaxed/simple;
	bh=XKWMPLPo1WH5vVWYpjrlZj/2ZgPVqf4aRksu4KN91vE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CcHbyRi7aaoJDx6W5g87UjfE6LIo7HslBkFD8TvxZVeyI2dgIOF0wZp54xn2qzZW8w2siy5WXfFbW5CjNcSbNABsKaH3/BNJIoFHVRdDEQDwnGpXNHusTGO0LjurjJHKa3l8ejHo5TJko/5rY4lSRdmJ5Jn1GIwchrVTnq1gY3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BMCzPTgX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BMCzPTgX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742993094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8fvRV+vXgcsKP9jFTuEcTFLOervcwZLIt7LcD5mec5E=;
	b=BMCzPTgXnvFB4tTF5oTw39HPnUe0+dlKZYUgdCEXnadkS5Ha1yrhcnbop6RiH+7xtY4MmT
	fCe2fY2yoyv9f+GxGtngAY2g/MzFEz4vcv4jUwpi5wuog3chqy9orCn9Kto2MfaH7jKk1+
	TbfD7WV7zUtAZu8cMmQbvw9ydKvASvQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-260-t5IosiLiOCGREskSV5Cxig-1; Wed,
 26 Mar 2025 08:44:47 -0400
X-MC-Unique: t5IosiLiOCGREskSV5Cxig-1
X-Mimecast-MFC-AGG-ID: t5IosiLiOCGREskSV5Cxig_1742993085
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 64F7119560B0;
	Wed, 26 Mar 2025 12:44:44 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.42])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A0B1419560AB;
	Wed, 26 Mar 2025 12:44:37 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 26 Mar 2025 13:44:11 +0100 (CET)
Date: Wed, 26 Mar 2025 13:44:03 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Dominique Martinet <asmadeus@codewreck.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>,
	brauner@kernel.org, dhowells@redhat.com, jack@suse.cz,
	jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev,
	swapnil.sapkal@amd.com, syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk, v9fs@lists.linux.dev
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
Message-ID: <20250326124402.GD30181@redhat.com>
References: <af0134a7-6f2a-46e1-85aa-c97477bd6ed8@amd.com>
 <CAGudoHH9w8VO8069iKf_TsAjnfuRSrgiJ2e2D9-NGEDgXW+Lcw@mail.gmail.com>
 <7e377feb-a78b-4055-88cc-2c20f924bf82@amd.com>
 <f7585a27-aaef-4334-a1de-5e081f10c901@amd.com>
 <ff294b3c-cd24-4aa6-9d03-718ff7087158@amd.com>
 <20250325121526.GA7904@redhat.com>
 <20250325130410.GA10828@redhat.com>
 <f855a988-d5e9-4f5a-8b49-891828367ed7@amd.com>
 <Z-LEsPFE4e7TTMiY@codewreck.org>
 <20250326121946.GC30181@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326121946.GC30181@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 03/26, Oleg Nesterov wrote:
>
> Hmm... I don't understand why the 2nd vfs_poll(ts->wr) depends on the
> ret from vfs_poll(ts->rd), but I assume this is correct.

I meant, if pt != NULL and ts->rd != ts->wr we need both
vfs_poll(ts->rd) and vfs_poll(ts->wr) ?

and the reproducer writes to the pipe before it mounts 9p...

Prateek, this is just a shot in the dark but since you can reproduce,
can you check if the patch below makes any difference?

Oleg.

--- x/net/9p/trans_fd.c
+++ x/net/9p/trans_fd.c
@@ -234,8 +234,10 @@ p9_fd_poll(struct p9_client *client, str
 	}
 
 	ret = vfs_poll(ts->rd, pt);
-	if (ts->rd != ts->wr)
+	if (ts->rd != ts->wr) {
+		if (pt != NULL) vfs_poll(ts->wr, pt);
 		ret = (ret & ~EPOLLOUT) | (vfs_poll(ts->wr, pt) & ~EPOLLIN);
+	}
 	return ret;
 }
 

