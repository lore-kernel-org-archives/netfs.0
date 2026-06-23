Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851DA375AAD
	for <netfs@lists.linux.dev>; Tue, 23 Jun 2026 11:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782215539; cv=none; b=fSqypB+L6+nnj9xaWzthogI9DM/Db/yXXkoP4kj7r7UVxVBuKKgAbJwWsQ+hu8heo56jbSiu1OJWAIEOPHLeRB/KCNgQCkrrNuOJ+tUZntJluwX7tmJuySBdVHR8fbhwx+5tkxCByqtSbFw7qYh12h0TyaOiQJjUXl7/FS/my5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782215539; c=relaxed/simple;
	bh=vSMq+tVBRFkyDtQqvUY0r/b24xLj9JOEUkggBLpr+3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GLlViUPA+nTB/pBWn+9kFCeXlQ1Bw7KDEfV4eMtVr/De8sMItdJxakVDZfV8nDwqL1l/OrJ8v4YxjjFEH6Pm0RVvRcyNjev+tZ35g6YSkUN62+/gSv7Z9f31rFRLf5Q3Jdqn/KrK477KZhA6h/1xzMijMMCqsxfXOMGnKdkIj5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com; spf=pass smtp.mailfrom=chenxiaosong.com; dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b=baLzCHBZ; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b="baLzCHBZ"
Message-ID: <33cc8eb4-8831-49b0-80d6-b06544a37920@chenxiaosong.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chenxiaosong.com;
	s=key1; t=1782215532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HbHk9IuwP6sXbnZHOGBepgq7/3h6RydFMctmwTcnnXE=;
	b=baLzCHBZiCMvODbcElXie9bXXAYXoQSsVix4j82AsGf2L0jSaJKJ1FefcKWnC3r6iptHIP
	6z9boTPXO4s+uyLao5JCtf7fGRULt6DKsSqhHNlx506XqWRGSzLhk3IMcHQxkozhCR1WGw
	OwgsAtR57qiB78+yoCkLdWtn3lW9sg3AEBEN+tkJFH9oaUNydw6Wo3vs8KUZFzug5mmCH7
	zF6kBQpJcfiCi5C4lPNcpeIdnkMLMNt5102SSNoV2IxkMB/vspf7gq6+vUZP1f7fIkyhUj
	Kg3pqGVUUwx7VoP0q0zJwCXppXP0+Tp5vkeHO/Rv/uRItdPHwEXqechS59ZE6w==
Date: Tue, 23 Jun 2026 19:52:05 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH] netfs: Fix UAF in netfs_unbuffered_write() on failed
 preparation
To: hongao <hongao@uniontech.com>, David Howells <dhowells@redhat.com>
Cc: Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+3c74b1f0c372e98efc32@syzkaller.appspotmail.com
References: <FA1EF9EEE4C1415E+20260530011403.1686344-1-hongao@uniontech.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
In-Reply-To: <FA1EF9EEE4C1415E+20260530011403.1686344-1-hongao@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi hongao and David,

After applying this patch, I can still reproduce the use-after-free issue.

C reproducer: https://syzkaller.appspot.com/text?tag=ReproC&x=171b697e580000

Note that QEMU should be started with the following virtfs option:

   -virtfs ...,mount_tag=syz,...

On 5/30/26 09:14, hongao wrote:
> If write subrequest preparation fails, netfs_unbuffered_write() calls
> netfs_write_subrequest_terminated() and then reads subreq->error to set
> wreq->error.
> 
> However, netfs_write_subrequest_terminated() consumes a reference to the
> subrequest through netfs_put_subrequest(), so the subrequest may be freed
> before netfs_unbuffered_write() reads subreq->error again.  This can
> trigger a slab-use-after-free.
> 
> Save the error locally before terminating the subrequest, and use the
> saved value afterwards.
> 
> Fixes: a0b4c7a49137 ("netfs: Fix unbuffered/DIO writes to dispatch subrequests in strict sequence")
> Reported-by: syzbot+3c74b1f0c372e98efc32@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3c74b1f0c372e98efc32
> 
> Signed-off-by: hongao <hongao@uniontech.com>
> ---
>   fs/netfs/direct_write.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
> index 25f8ceb15fad..2d5361702076 100644
> --- a/fs/netfs/direct_write.c
> +++ b/fs/netfs/direct_write.c
> @@ -115,8 +115,9 @@ static int netfs_unbuffered_write(struct netfs_io_request *wreq)
>   
>   		/* Check if (re-)preparation failed. */
>   		if (unlikely(test_bit(NETFS_SREQ_FAILED, &subreq->flags))) {
> -			netfs_write_subrequest_terminated(subreq, subreq->error);
> -			wreq->error = subreq->error;
> +			ret = subreq->error;
> +			wreq->error = ret;
> +			netfs_write_subrequest_terminated(subreq, ret);
>   			break;
>   		}
>   

-- 
ChenXiaoSong <chenxiaosong@chenxiaosong.com>
Chinese Homepage: https://chenxiaosong.com
English Homepage: https://chenxiaosong.com/en

