Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049011B960
	for <netfs@lists.linux.dev>; Mon, 19 Aug 2024 01:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724031106; cv=none; b=KyoKXcCsbCNqOUg2DB0GkDg7C+aZ8ZqcRdQz2h9XN70rk8x9Mb7neYC5aXIr7wQUczVxNtcaUT3H1DM0u7x5WTgMs6Bnt3JVlPFdMXkxbT7O9eRUgzTFFMpjROjt1tMmMKLFhtyPgBytQaim0pWlPTHqmianqLvNlKhx9g12hd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724031106; c=relaxed/simple;
	bh=HQ5/dI0Bdm9EgRmrjx9EPAhLLGK7WM59NQ2TNadHhEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oFSiUowe64KUVWDhyi6zGFMc+bfOOxlIibMVMN5MkwkwQDIkrJh1uKhUk5SkRyVv/vYOUo5WxXThMZDVVFPgIwptc11TK7MwaIovCBfZtedOJBec9AcfyN+BVvb6jQN32w30u6li2mKuCmtILbMbWQvlIyz7xNrK1YSphifdFRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M0mDOINY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M0mDOINY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724031104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+CCs3r6hJH4DMfIS+VQJMNGzaRyfgBQFWrMHED7vXl8=;
	b=M0mDOINYc6ENZiTCuW19AIQ664a+9AtiJyLWVPKb1eHRxLyYhkARjI+NIyIxLAomDONFv5
	Xklc+hKpC7hExmGhg1kt0DHdTWvkXt57lJDu2r+/9BSxPZ67kZUYS2T2ncToaR+4/FOTcw
	n1OqDIcUI8vDp6yI1LUPp1Uj3YOXoLg=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-WIqCNn7zNnu9o4h58GVHlw-1; Sun, 18 Aug 2024 21:31:42 -0400
X-MC-Unique: WIqCNn7zNnu9o4h58GVHlw-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-708f8258621so3103954a34.0
        for <netfs@lists.linux.dev>; Sun, 18 Aug 2024 18:31:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724031101; x=1724635901;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+CCs3r6hJH4DMfIS+VQJMNGzaRyfgBQFWrMHED7vXl8=;
        b=mjWZV4p/bBiVgJsTVehZwe3u5cx+bCKjtuS2MnYCR9vSmr/qt7917FpjVTPPWhF0Rg
         nZe+Y7DDB5HxZoK67iQQIOTXfUZOLQdNvD1oK3wiUd10+dSk8gCVWG+50UC8BtrCaRyb
         7ayi5H0W/3+kOvY1vHzu/dmwfTI8RqQAi+1aUdM/hxL8XBWAj6rF7FVZ5QrV/ZfjC/2B
         gMrhapvRNaFDbMk0EZwSR/LuMHOpSGqjNzG5kY4L2+yOOGbIZF9Xv5wEOpRyaAtbGwKf
         X7XS73OPOwCwoElCsGjWrLbh9hQreXo5RJUlmDRmTzsDDA1CtbQ9VtBlufja9VUqBnpP
         hCxg==
X-Forwarded-Encrypted: i=1; AJvYcCWcw2V6nJbwtD6FIeQ7nowvv6x4WFj9rpLkcCb7sR7RazmxFp0vEvDaLGbsVVIRIrorSxndp9x8XVd3jZ+LmZGvtCSb180=
X-Gm-Message-State: AOJu0Yz9D/OSFY/JWsnUUsada+FAouD5XiMzw2JRd4Zcmre3wyVmyU+u
	zqqZjrsMeFPXirHWLMRQlzx1Er/c9/5pyKiaoyzPQnJB/QkyWU3MkgJJVCq+AljdAsZMH/k5I8A
	2JR8aOA0mL0QYUAId7eUbRPxhm/0+eyQxathkqAePASq5y6BruUTB
X-Received: by 2002:a05:6830:919:b0:709:47a6:627c with SMTP id 46e09a7af769-70cac84915emr9933899a34.4.1724031101680;
        Sun, 18 Aug 2024 18:31:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6X1a7pPkn+SUa6v7Wbgpm6Nj8OlxFtxYJDnVVkia7xEYC08b4X5v9+urMoiKWMtuL+brG/w==
X-Received: by 2002:a05:6830:919:b0:709:47a6:627c with SMTP id 46e09a7af769-70cac84915emr9933887a34.4.1724031101377;
        Sun, 18 Aug 2024 18:31:41 -0700 (PDT)
Received: from [10.72.116.30] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b61dd9c9sm6712306a12.41.2024.08.18.18.31.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Aug 2024 18:31:40 -0700 (PDT)
Message-ID: <de34373f-7e53-406f-9ac3-cd9d7dc1c889@redhat.com>
Date: Mon, 19 Aug 2024 09:31:32 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] netfs, ceph: Partially revert "netfs: Replace PG_fscache
 by setting folio->private and marking dirty"
To: David Howells <dhowells@redhat.com>,
 Christian Brauner <brauner@kernel.org>
Cc: Max Kellermann <max.kellermann@ionos.com>,
 Ilya Dryomov <idryomov@gmail.com>, Jeff Layton <jlayton@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, ceph-devel@vger.kernel.org,
 netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <2181767.1723665003@warthog.procyon.org.uk>
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <2181767.1723665003@warthog.procyon.org.uk>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/15/24 03:50, David Howells wrote:
>      
> This partially reverts commit 2ff1e97587f4d398686f52c07afde3faf3da4e5c.
>
> In addition to reverting the removal of PG_private_2 wrangling from the
> buffered read code[1][2], the removal of the waits for PG_private_2 from
> netfs_release_folio() and netfs_invalidate_folio() need reverting too.
>
> It also adds a wait into ceph_evict_inode() to wait for netfs read and
> copy-to-cache ops to complete.
>
> Fixes: 2ff1e97587f4 ("netfs: Replace PG_fscache by setting folio->private and marking dirty")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Max Kellermann <max.kellermann@ionos.com>
> cc: Ilya Dryomov <idryomov@gmail.com>
> cc: Xiubo Li <xiubli@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: ceph-devel@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> Link: https://lore.kernel.org/r/3575457.1722355300@warthog.procyon.org.uk [1]
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8e5ced7804cb9184c4a23f8054551240562a8eda [2]
> ---
>   fs/ceph/inode.c |    1 +
>   fs/netfs/misc.c |    7 +++++++
>   2 files changed, 8 insertions(+)
>
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 71cd70514efa..4a8eec46254b 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -695,6 +695,7 @@ void ceph_evict_inode(struct inode *inode)
>   
>   	percpu_counter_dec(&mdsc->metric.total_inodes);
>   
> +	netfs_wait_for_outstanding_io(inode);
>   	truncate_inode_pages_final(&inode->i_data);
>   	if (inode->i_state & I_PINNING_NETFS_WB)
>   		ceph_fscache_unuse_cookie(inode, true);
> diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
> index 83e644bd518f..554a1a4615ad 100644
> --- a/fs/netfs/misc.c
> +++ b/fs/netfs/misc.c
> @@ -101,6 +101,8 @@ void netfs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
>   
>   	_enter("{%lx},%zx,%zx", folio->index, offset, length);
>   
> +	folio_wait_private_2(folio); /* [DEPRECATED] */
> +
>   	if (!folio_test_private(folio))
>   		return;
>   
> @@ -165,6 +167,11 @@ bool netfs_release_folio(struct folio *folio, gfp_t gfp)
>   
>   	if (folio_test_private(folio))
>   		return false;
> +	if (unlikely(folio_test_private_2(folio))) { /* [DEPRECATED] */
> +		if (current_is_kswapd() || !(gfp & __GFP_FS))
> +			return false;
> +		folio_wait_private_2(folio);
> +	}
>   	fscache_note_page_release(netfs_i_cookie(ctx));
>   	return true;
>   }

Just back from PTOs.

This LGTM and I will run the test today locally.

Thanks David.

- Xiubo


