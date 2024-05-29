Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10383158844
	for <netfs@lists.linux.dev>; Wed, 29 May 2024 14:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716992930; cv=none; b=e6KQyjR7Ui6T6R/VwgyVeCT823Clrf9ol6Ha6AB9b/h1KifbkhjU1Dsam2q8qurcd0Y9epKAAKOe5ke5aOXyhIwnDzwhQHJtGxhc5EyVIdDy8hMKg+hjBSs6Eei1Mf0gVnWypqLjoLKzHWh1ir3lYe/UoNW8NJctGLGw1Zym3BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716992930; c=relaxed/simple;
	bh=YMQyhhaP6Gg3VRgatRDCJBiv0lWaUNKjwv78w6uHqZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R17whpRyk8jR+HVSHur5cgILSnj3tUSHEt+KRK4KVnzOIMiqVWaNHRmn9eDvZYNJ8i8yYGiM/oHT5I+Go4IZbc7GvFecREttfxi17U7WICszLooemheBKYNVJroCXDtuY83tmyaLhGzptApdtBnGF9LeZXBcdTjUhFZZ4tZoTXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mw8j/CgV; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mw8j/CgV"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716992918; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Oje62Ov6FUBQ4DHAsaEy7GE8Yt2ouQ/knXBYAIm0bWE=;
	b=mw8j/CgV/4aYJxy1mQgVGQg1YxAhvc0mxSSeSAgQkpRRCd8NaV8RXY7cZHl2bek/h80eaKAK/EREjWe/QcnSstPxHjDX2dqcXNIJM37g8RyFhapq4YpEzqu1IzVW140eEcv6y/OjkaAcJDdiiAYnt+0JiiJ+rh0L30NDQ4zl7Mo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W7U1T.u_1716992916;
Received: from 192.168.3.4(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W7U1T.u_1716992916)
          by smtp.aliyun-inc.com;
          Wed, 29 May 2024 22:28:37 +0800
Message-ID: <2dc48e89-cd3f-4736-8847-4d23bcad27e5@linux.alibaba.com>
Date: Wed, 29 May 2024 22:28:35 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/12] cachefiles: some bugfixes and cleanups for
 ondemand requests
To: Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev,
 dhowells@redhat.com, jlayton@kernel.org, libaokun@huaweicloud.com
Cc: jefflexu@linux.alibaba.com, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, houtao1@huawei.com,
 yukuai3@huawei.com, wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>,
 Gao Xiang <xiang@kernel.org>
References: <20240522114308.2402121-1-libaokun@huaweicloud.com>
 <20240529-lehrling-verordnen-e5040aa65017@brauner>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240529-lehrling-verordnen-e5040aa65017@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christian,

On 2024/5/29 19:07, Christian Brauner wrote:
> On Wed, 22 May 2024 19:42:56 +0800, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> Hi all!
>>
>> This is the third version of this patch series. The new version has no
>> functional changes compared to the previous one, so I've kept the previous
>> Acked-by and Reviewed-by, so please let me know if you have any objections.
>>
>> [...]
> 
> So I've taken that as a fixes series which should probably make it upstream
> rather sooner than later. Correct?

Yeah, many thanks for picking these up!  AFAIK, they've already been
landed downstream for a while so it'd be much better to address
these upstream. :-)

Thanks,
Gao Xiang

> 
> ---
> 
> Applied to the vfs.fixes branch of the vfs/vfs.git tree.
> Patches in the vfs.fixes branch should appear in linux-next soon.
> 
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
> 
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
> 
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.fixes
> 
> [01/12] cachefiles: add output string to cachefiles_obj_[get|put]_ondemand_fd
>          https://git.kernel.org/vfs/vfs/c/cc5ac966f261
> [02/12] cachefiles: remove requests from xarray during flushing requests
>          https://git.kernel.org/vfs/vfs/c/0fc75c5940fa
> [03/12] cachefiles: fix slab-use-after-free in cachefiles_ondemand_get_fd()
>          https://git.kernel.org/vfs/vfs/c/de3e26f9e5b7
> [04/12] cachefiles: fix slab-use-after-free in cachefiles_ondemand_daemon_read()
>          https://git.kernel.org/vfs/vfs/c/da4a82741606
> [05/12] cachefiles: remove err_put_fd label in cachefiles_ondemand_daemon_read()
>          https://git.kernel.org/vfs/vfs/c/3e6d704f02aa
> [06/12] cachefiles: add consistency check for copen/cread
>          https://git.kernel.org/vfs/vfs/c/a26dc49df37e
> [07/12] cachefiles: add spin_lock for cachefiles_ondemand_info
>          https://git.kernel.org/vfs/vfs/c/0a790040838c
> [08/12] cachefiles: never get a new anonymous fd if ondemand_id is valid
>          https://git.kernel.org/vfs/vfs/c/4988e35e95fc
> [09/12] cachefiles: defer exposing anon_fd until after copy_to_user() succeeds
>          https://git.kernel.org/vfs/vfs/c/4b4391e77a6b
> [10/12] cachefiles: Set object to close if ondemand_id < 0 in copen
>          https://git.kernel.org/vfs/vfs/c/4f8703fb3482
> [11/12] cachefiles: flush all requests after setting CACHEFILES_DEAD
>          https://git.kernel.org/vfs/vfs/c/85e833cd7243
> [12/12] cachefiles: make on-demand read killable
>          https://git.kernel.org/vfs/vfs/c/bc9dde615546
