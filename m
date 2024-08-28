Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF62B1EB35
	for <netfs@lists.linux.dev>; Wed, 28 Aug 2024 14:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724853916; cv=none; b=TdLSQ8OzNdTc+HVU5xqmHzpByqSnh+WLJJrwN5MVcAqJ86vdIPNSfrxGgu/WToJ1FY1RsDBDaogPDydUnkf91soFl3B7YB/uST+bFCb3T2tAfjl1W5fCKbRQ5YC8IjLftaDhMO2NZlam0Zf9FP16P/PxUmiUjxOuiZbKCQ2Hwrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724853916; c=relaxed/simple;
	bh=s/BPcGNsip45eWRCYYjs8HNLwysSk2FycKjmUY22ucc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CC1OkdK66yVsD9QFdHDvW9zhb0A/qrWaofwQepAYKq99NNKJeTw88oTkg+DUl6apAIF813RzPLKruJn/eGQc4fecCAR+eqGfZ6wz/DbhCu6cqgaTKbdgmI6ZRA0lg65te6zk1BFmbaOqjnB4wsaJr3ZxQxD0tnTO9TNG+K24jl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Wv5lC4Z9Xz4f3jdP
	for <netfs@lists.linux.dev>; Wed, 28 Aug 2024 22:04:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3D8B21A018D
	for <netfs@lists.linux.dev>; Wed, 28 Aug 2024 22:05:10 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP4 (Coremail) with SMTP id gCh0CgCXv4WULs9mF7jaCw--.47393S3;
	Wed, 28 Aug 2024 22:05:10 +0800 (CST)
Message-ID: <11c591fd-221b-4eeb-a0bd-e9e303d391a6@huaweicloud.com>
Date: Wed, 28 Aug 2024 22:05:08 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cachefiles: fix dentry leak in cachefiles_open_file()
To: David Howells <dhowells@redhat.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 Jeff Layton <jlayton@kernel.org>, stable@kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>,
 Gao Xiang <hsiangkao@linux.alibaba.com>, Hou Tao <houtao1@huawei.com>,
 Jingbo Xu <jefflexu@linux.alibaba.com>, Yang Erkun <yangerkun@huawei.com>,
 Yu Kuai <yukuai3@huawei.com>, Zizhi Wo <wozizhi@huawei.com>,
 Baokun Li <libaokun1@huawei.com>, Baokun Li <libaokun@huaweicloud.com>
References: <5b7455f8-4637-4ec0-a016-233827131fb2@huaweicloud.com>
 <20240826040018.2990763-1-libaokun@huaweicloud.com>
 <467d9b9b-34b4-4a94-95c1-1d41f0a91e05@web.de>
 <988772.1724850113@warthog.procyon.org.uk>
Content-Language: en-US
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <988772.1724850113@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXv4WULs9mF7jaCw--.47393S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZw18uFyrZr4rury8CF1Dtrb_yoW5XFyDpF
	WSyr1UJry8WrWkGr4kAF1DZryFyrZFqw1UXFn8WF1DArs0qrWaqr1UXrn0gr15Jr4kJr45
	XF1Uua43ZryUJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0pRHUDLUUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAJBWbO338bKgABs1

Hello David,

Thanks for the review.

On 2024/8/28 21:01, David Howells wrote:
> Baokun Li <libaokun@huaweicloud.com> wrote:
>
>> Actually, at first I was going to release the reference count of the
>> dentry uniformly in cachefiles_look_up_object() and delete all dput()
>> in cachefiles_open_file(),
> You couldn't do that anyway, since kernel_file_open() steals the caller's ref
> if successful.
Ignoring kernel_file_open(), we now put a reference count of the dentry
whether cachefiles_open_file() returns true or false.

And cachefiles_open_file() doesn't modify the dentry, so I'm thinking it's
releasing the reference count of the dentry that was got by
lookup_positive_unlocked() in cachefiles_look_up_object().

I'm not sure how kernel_file_open() steals the reference count,
am I missing something?


The code is as follows:

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index f53977169db4..2b3f9935dbb4 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -595,14 +595,12 @@ static bool cachefiles_open_file(struct 
cachefiles_object *object,
          * write and readdir but not lookup or open).
          */
         touch_atime(&file->f_path);
-       dput(dentry);
         return true;

  check_failed:
         fscache_cookie_lookup_negative(object->cookie);
         cachefiles_unmark_inode_in_use(object, file);
         fput(file);
-       dput(dentry);
         if (ret == -ESTALE)
                 return cachefiles_create_file(object);
         return false;
@@ -611,7 +609,6 @@ static bool cachefiles_open_file(struct 
cachefiles_object *object,
         fput(file);
  error:
         cachefiles_do_unmark_inode_in_use(object, d_inode(dentry));
-       dput(dentry);
         return false;
  }

@@ -654,7 +651,9 @@ bool cachefiles_look_up_object(struct 
cachefiles_object *object)
                 goto new_file;
         }

-       if (!cachefiles_open_file(object, dentry))
+       ret = cachefiles_open_file(object, dentry);
+       dput(dentry);
+       if (!ret)
                 return false;

         _leave(" = t [%lu]", file_inode(object->file)->i_ino);


Regards,
Baokun

>> but this may conflict when backporting the code to stable. So just keep it
>> simple to facilitate backporting to stable.
> Prioritise upstream, please.
>
> I think Markus's suggestion of inserting a label and switching to a goto is
> better.
>
> Thanks,
> David

