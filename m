Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EBB1FDA
	for <netfs@lists.linux.dev>; Wed, 26 Jun 2024 03:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719371001; cv=none; b=kOjm4AmieNVrDY9ALwEkp1SrTc4KeAReo98YMyqPIlEFgUlVSzng9AyjcTGF4M2qoZzLsSrHxriOCjZRTp1lU1sC+cx40huudAD6rQn+RnuN01wPqrKoXVzFauY0BjEQDccljMjcVF/jnxeATtCZ2/E0bMJjU7ApFVARJoj8+YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719371001; c=relaxed/simple;
	bh=czBM482pH9l++pF3ssBG1WFBJnTvb536DFZk7EolOfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V/I9GzXDpWjjTRO+Wc/cvAMtcp/vg+lURxhAF6AaaArhFaIcwTWimrFu9CQjDD19bBT/xY2n5u1Hzoc6YfEXvNySMzcy3n0j2ah/4+1FvAOMQOjC8HhloPFFy/XD+s2/EaCH9Q/qv6NfloALU3rFQ8aMGRS+GNXyutRiryyn11s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W862Z6K2wz4f3kvG
	for <netfs@lists.linux.dev>; Wed, 26 Jun 2024 11:03:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 0A8591A0181
	for <netfs@lists.linux.dev>; Wed, 26 Jun 2024 11:03:15 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP1 (Coremail) with SMTP id cCh0CgAXQn7uhHtmOLVmAQ--.51004S3;
	Wed, 26 Jun 2024 11:03:14 +0800 (CST)
Message-ID: <4f357745-67a6-4f2e-8d69-2f72dc8a42d0@huaweicloud.com>
Date: Wed, 26 Jun 2024 11:03:10 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 0/5] cachefiles: some bugfixes for withdraw and
 xattr
To: netfs@lists.linux.dev, dhowells@redhat.com, jlayton@kernel.org
Cc: hsiangkao@linux.alibaba.com, jefflexu@linux.alibaba.com,
 zhujia.zj@bytedance.com, linux-erofs@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 yangerkun@huawei.com, houtao1@huawei.com, yukuai3@huawei.com,
 wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>
References: <20240522115911.2403021-1-libaokun@huaweicloud.com>
Content-Language: en-US
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <20240522115911.2403021-1-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgAXQn7uhHtmOLVmAQ--.51004S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uF13WrW3AryDKrWxAF18Krg_yoW8WrW5pF
	WakF43ArykW397Grn3Jr45JF1fA3yfJF4vgw17Wr1UAwn5Xr1YvF4Iyr15ZFyUCrn7tws3
	t3WjgFy7Ww1UA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAFBV1jkHn9PQADsW

A gentle ping.

On 2024/5/22 19:59, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
>
> Hi all!
>
> There are some fixes for some cachefiles generic processes. We found these
> issues when testing the on-demand mode, but the non-on-demand mode is also
> involved. The following is a brief overview of the patches, see the patches
> for more details.
>
> Patch 1-2: Add fscache_try_get_volume() helper function to avoid
> fscache_volume use-after-free on cache withdrawal.
>
> Patch 3: Fix cachefiles_lookup_cookie() and cachefiles_withdraw_cache()
> concurrency causing cachefiles_volume use-after-free.
>
> Patch 4-5: Propagate error codes returned by vfs_getxattr() to avoid
> endless loops.
>
> Comments and questions are, as always, welcome.
>
> Thanks,
> Baokun
>
> Baokun Li (5):
>    netfs, fscache: export fscache_put_volume() and add
>      fscache_try_get_volume()
>    cachefiles: fix slab-use-after-free in fscache_withdraw_volume()
>    cachefiles: fix slab-use-after-free in cachefiles_withdraw_cookie()
>    cachefiles: correct the return value of
>      cachefiles_check_volume_xattr()
>    cachefiles: correct the return value of cachefiles_check_auxdata()
>
>   fs/cachefiles/cache.c          | 45 +++++++++++++++++++++++++++++++++-
>   fs/cachefiles/volume.c         |  1 -
>   fs/cachefiles/xattr.c          |  5 +++-
>   fs/netfs/fscache_volume.c      | 14 +++++++++++
>   fs/netfs/internal.h            |  2 --
>   include/linux/fscache-cache.h  |  6 +++++
>   include/trace/events/fscache.h |  4 +++
>   7 files changed, 72 insertions(+), 5 deletions(-)
>

-- 
With Best Regards,
Baokun Li

