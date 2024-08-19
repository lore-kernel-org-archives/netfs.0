Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0771607A4
	for <netfs@lists.linux.dev>; Mon, 19 Aug 2024 11:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724067376; cv=none; b=GFVMhnt3+3kUTd/2yhPFiDCXpzgLOunXj1EJHJRafpdSm1uuPnsvQpUJ/JMUfPLktrtW8XP5Gbahc+9XjGzNqZvzyKTW64TNg08nFrOGEUFsTGBccD9FQUir+2EBsaRG5st3LbOPiOlH5MIpWU6eN39oFK7nr3KgbZDVQi9CLNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724067376; c=relaxed/simple;
	bh=cSSA2MzQwLDw570RN8aKC6T5cPXTRIk+Cej41bGnH1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qs5f8dCeLn5l3T5lS9vU6ncnnJhDwipwNjNcOitN6uGcfozgT6DoK6QphhEOO4oidO0HbxNe8hQagnxtwPHsA3sdYinWG56PjiNy+2PG9Bx2+XKYdxAAdCaR2RaUs/+dbFTcfquirrTNhDdpgA+jdCW+dU2Fm5UF41ayrO2tyLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WnVsQ3ynxz4f3n6Y
	for <netfs@lists.linux.dev>; Mon, 19 Aug 2024 19:35:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 889F91A111E
	for <netfs@lists.linux.dev>; Mon, 19 Aug 2024 19:36:09 +0800 (CST)
Received: from [10.174.177.210] (unknown [10.174.177.210])
	by APP4 (Coremail) with SMTP id gCh0CgCHr4UoLsNm4E+ACA--.62925S3;
	Mon, 19 Aug 2024 19:36:09 +0800 (CST)
Message-ID: <3a412d70-da59-2ad4-4432-fe452eaaaa06@huaweicloud.com>
Date: Mon, 19 Aug 2024 19:36:08 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] netfs: fix the mismatch used for CONFIG_FSCACHE_DEBUG
To: David Howells <dhowells@redhat.com>
Cc: jlayton@kernel.org, hsiangkao@linux.alibaba.com, netfs@lists.linux.dev
References: <20240323092312.1643320-1-yangerkun@huawei.com>
 <3402464.1724066908@warthog.procyon.org.uk>
From: yangerkun <yangerkun@huaweicloud.com>
In-Reply-To: <3402464.1724066908@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHr4UoLsNm4E+ACA--.62925S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUU5M7kC6x804xWl14x267AKxVWUJVW8JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjc
	xK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG
	8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
	0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/



在 2024/8/19 19:28, David Howells 写道:
> yangerkun <yangerkun@huawei.com> wrote:
> 
>> The name of debug config used in fs/netfs/internal.h has a mismatch
>> compared to the define in fs/netfs/Kconfig, which lead to that debug for
>> netfs won't work.
> 
> Thanks, however this patch is now obsolete as of commit
> fcad93360df4d04b172dba85b976c9f38ee0d5e0:
> 
>      netfs: Rename CONFIG_FSCACHE_DEBUG to CONFIG_NETFS_DEBUG

Oh, sorry, I have not check the latest kernel does this problem still
exist, it's me fault, thanks a lot for you point out this.

> 
> David
> 
> 

