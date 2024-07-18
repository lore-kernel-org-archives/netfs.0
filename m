Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E20643ABD
	for <netfs@lists.linux.dev>; Thu, 18 Jul 2024 08:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721290468; cv=none; b=XqUaIU7gGaNUb6IFLXdUhUmnPwy8KZl3ErlKDFRULsVCHYuhCwHXWzzjYRw57QLmxoGbq/ArhEP0+SqG68SrKTV4YEhnDC472FoUN4ueOqbmChgxtdjcTMcN+cee1CGGoZTWulqR6Yo3etN7uU1TIfucDq2Qr8zw9nPh1faoFo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721290468; c=relaxed/simple;
	bh=tE0ZGSstQrFl1LpYvSo/NfHAWwsQO/HNmRb+mFYLwi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FhucA7meQ0AjK8Yn5PXmV0sCzvO83ekmATisBXtiU1g8Z23hBIM3WfE+aLe4ZJn2jgvT2A07bKiHjYAVzgwtB3V0Nv+lIKdzBVX/AKsjnTLxxpV5ayR7YxthjPM3BRCgpwyUR6HF29Nm2Bv55v2wAidgHU5SWJkBvsqCQtwxSBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BCF9R3Pr; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BCF9R3Pr"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721290455; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=UrptSC+TAH3zMZiJMSAgffTMkWEAF8yPUDbZHmy7FoM=;
	b=BCF9R3Pr6WxjdvmKuToLDsoWdgarVwkKUgQVjtsZU6LSIJCzXtV9T1LQnhP3MN6E3oQMadhddxSIYXVyAW7yZM2tIqJBuS0BX0eNWmGdjJYwdXBc3owzPkrzDlCnBJfB9+T9Y8Jq+can9dHusclGJpTZH/IelsizLObQMc4G9L4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032019045;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0WAnm5GR_1721290454;
Received: from 30.97.48.168(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WAnm5GR_1721290454)
          by smtp.aliyun-inc.com;
          Thu, 18 Jul 2024 16:14:15 +0800
Message-ID: <e035eaff-5d21-4399-9391-48a2674cc7b7@linux.alibaba.com>
Date: Thu, 18 Jul 2024 16:14:13 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: support direct IO for ondemand mode
To: Hongbo Li <lihongbo22@huawei.com>, jefflexu@linux.alibaba.com,
 David Howells <dhowells@redhat.com>
Cc: linux-erofs@lists.ozlabs.org, netfs@lists.linux.dev,
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Yue Hu <huyue2@coolpad.com>, Sandeep Dhavale <dhavale@google.com>
References: <20240718010545.2869515-1-lihongbo22@huawei.com>
 <54cf962f-dcdb-465a-ad83-f292f9b84b02@linux.alibaba.com>
 <ccd28477-6a95-4d8c-9960-2288e0aca311@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <ccd28477-6a95-4d8c-9960-2288e0aca311@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/7/18 15:11, Hongbo Li wrote:
> 
> 
> On 2024/7/18 10:40, Gao Xiang wrote:
>> Hi Hongbo,
>>
>> I'd like to request Jingbo's review too.
>>
>> On 2024/7/18 09:05, Hongbo Li wrote:
>>> erofs over fscache cannot handle the direct read io. When the file
>>> is opened with O_DIRECT flag, -EINVAL will reback. We support the
>>> DIO in erofs over fscache by bypassing the erofs page cache and
>>> reading target data into ubuf from fscache's file directly.
>>
>> Could you give more hints in the commit message on the target user
>> of fscache DIO?
>>
> To be honest, I haven't come across such containers using direct I/O yet. I've just run fio and some other tests for the direct mode in containers, and they failed during open. If a traditional container start using direct I/O when it's then migrated to the erofs over fscache solution (ie. Nydus), it won't run properly. This is because the current on-demand mode of erofs does not support direct I/O. Currently, I thought there are two approaches to solve this: 1. direct I/O can fallback to buffered I/O (simpler but seems non-reasonable); 2. implement the direct I/O process like this way.

I think benchmark might be a clear use case, personally
I'm fine to add direct I/O for unencoded I/Os like this.

> 
> Thanks,
> Hongbo
> 
>> For Android use cases, direct I/O support is mainly used for loop
>> device direct mode.
>>
>>>
>>> The alignment for buffer memory, offset and size now is restricted
>>> by erofs, since `i_blocksize` is enough for the under filesystems.
>>>
>>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>>> ---
>>>   fs/erofs/data.c    |  3 ++
>>>   fs/erofs/fscache.c | 95 +++++++++++++++++++++++++++++++++++++++++++---
>>>   2 files changed, 93 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
>>> index 8be60797ea2f..dbfafe358de4 100644
>>> --- a/fs/erofs/data.c
>>> +++ b/fs/erofs/data.c
>>> @@ -391,6 +391,9 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>>>                iov_iter_alignment(to)) & blksize_mask)
>>>               return -EINVAL;
>>> +        if (erofs_is_fscache_mode(inode->i_sb))
>>> +            return generic_file_read_iter(iocb, to);
>>> +
>>>           return iomap_dio_rw(iocb, to, &erofs_iomap_ops,
>>>                       NULL, 0, NULL, 0);
>>>       }
>>> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
>>> index fda16eedafb5..f5a09b168539 100644
>>> --- a/fs/erofs/fscache.c
>>> +++ b/fs/erofs/fscache.c
>>> @@ -35,6 +35,8 @@ struct erofs_fscache_io {
>>>   struct erofs_fscache_rq {
>>>       struct address_space    *mapping;    /* The mapping being accessed */
>>> +    struct iov_iter        *iter;        /* dst buf for direct io */
>>> +    struct completion    done;        /* for synced direct io */
>>>       loff_t            start;        /* Start position */
>>>       size_t            len;        /* Length of the request */
>>>       size_t            submitted;    /* Length of submitted */
>>> @@ -76,7 +78,11 @@ static void erofs_fscache_req_put(struct erofs_fscache_rq *req)
>>>   {
>>>       if (!refcount_dec_and_test(&req->ref))
>>>           return;
>>> -    erofs_fscache_req_complete(req);
>>> +
>>> +    if (req->iter)
>>> +        complete(&req->done);
>>> +    else
>>> +        erofs_fscache_req_complete(req);
>>>       kfree(req);
>>>   }
>>> @@ -88,6 +94,7 @@ static struct erofs_fscache_rq *erofs_fscache_req_alloc(struct address_space *ma
>>>       if (!req)
>>>           return NULL;
>>>       req->mapping = mapping;
>>> +    req->iter = NULL;
>>>       req->start = start;
>>>       req->len = len;
>>>       refcount_set(&req->ref, 1);
>>> @@ -253,6 +260,55 @@ static int erofs_fscache_meta_read_folio(struct file *data, struct folio *folio)
>>>       return ret;
>>>   }
>>> +static int erofs_fscache_data_dio_read(struct erofs_fscache_rq *req)

Is it possible to merge this helper into erofs_fscache_data_read_slice?
Also it seems that it doesn't handle tailpacking inline files
(with EROFS_MAP_META set) although Nydus itself doesn't generate such
files but later I will add a new fscache backend in erofs-utils too.

Thanks,
Gao Xiang
